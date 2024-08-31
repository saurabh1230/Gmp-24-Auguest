import 'dart:convert';
import 'package:get_my_properties/data/models/body/vendor_locality.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class VendorMapController extends GetxController {
  GoogleMapController? mapController;
  double? latitude;
  double? longitude;
  String? address;
  String? locality;
  double? currentLatitude;
  double? currentLongitude;



  RxList<Map<String, String>> suggestions = <Map<String, String>>[].obs;

  List<LocalityMapData> _localities = [];
  List<LocalityMapData> get localities => _localities;


  String _selectedAddress = '';
  String get selectedAddress => _selectedAddress;
  void selectDirection(String val) {
    _selectedAddress = val;
    update();
  }







  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;  // Handle if location services are not enabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;  // Handle if permission is permanently denied
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;  // Handle if permission is denied
      }
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
    currentLatitude = currentPosition.latitude;
    currentLongitude = currentPosition.longitude;
    print('========> ${currentLatitude}');
    print('========> ${currentLongitude}');
    await updateAddress();
    update();
  }
  Future<void> updateAddress() async {
    if (latitude != null && longitude != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          address = '${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.postalCode ?? ''}, ${placemark.country ?? ''}';
          print('Address =>>>>: $address');
          print('City =>>>>: ${placemark.locality ?? 'Not available'}');
          print('State =>>>>: ${placemark.administrativeArea ?? 'Not available'}');
          print('Locality =>>>> : ${placemark.subLocality ?? 'Not available'}');
          print('Latitude =>>>>: $latitude');
          print('Longitude =>>>>: $longitude');
          print('========>currentLatitude ${currentLatitude}');
          print('========> currentLongitude ${currentLongitude}');
          // Check if _localities is null or if it contains any items
          _localities ??= [];

          // Create a new LocalityMapData object
          LocalityMapData newLoc = LocalityMapData(
            name: placemark.subLocality ?? 'Unknown',
            lat: currentLatitude!,
            lng: currentLongitude!,
          );

          // Check if _localities already contains the newLoc based on some criteria
          bool contains = _localities.any((loc) => loc.name == newLoc.name);

          if (!contains) {
            _localities.clear(); // Clear existing items
            _localities.add(newLoc); // Add the new item
            print('After Adding: ${_localities.length}');
            print('Controller Print : ${_localities[0].name}');
          } else {
            print('Locality already exists in the list.');
          }

        } else {
          print('No placemarks found');
        }
      } catch (e) {
        print("Error occurred while converting coordinates to address: $e");
      }
    } else {
      print('Latitude or Longitude is null');
    }
    update();
  }




  // Future<void> updateAddress() async {
  //   if (latitude != null && longitude != null) {
  //     try {
  //       List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
  //       if (placemarks.isNotEmpty) {
  //         Placemark placemark = placemarks.first;
  //         address = '${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.postalCode ?? ''}, ${placemark.country ?? ''}';
  //         print('Address =>>>>: $address');
  //         print('City =>>>>: ${placemark.locality ?? 'Not available'}');
  //         print('State =>>>>: ${placemark.administrativeArea ?? 'Not available'}');
  //         print('Locality =>>>> : ${placemark.subLocality ?? 'Not available'}');
  //         print('Latitude =>>>>: $latitude');
  //         print('Longitude =>>>>: $longitude');
  //
  //
  //       }
  //
  //
  //
  //     } catch (e) {
  //       print("Error occurred while converting coordinates to address: $e");
  //     }
  //   }
  // }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
  }

  String apiKey = 'AIzaSyBNB2kmkXSOtldNxPdJ6vPs_yaiXBG6SSU';  // Replace with your Google API Key

  Future<void> fetchSuggestions(String query) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final List<dynamic> predictions = data['predictions'];
        suggestions.value = predictions.map((prediction) {
          return {
            'description': prediction['description'] as String,
            'place_id': prediction['place_id'] as String,
          };
        }).toList();
      } else {
        suggestions.value = [];
      }
    } else {
      suggestions.value = [];
    }
  }

  Future<void> fetchLocationDetails(String placeId) async {
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];
        latitude = location['lat'];
        longitude = location['lng'];
        // if (locality != null) {
        //   LocalityMapData loc = LocalityMapData(
        //     name: locality!,
        //     lat: latitude!,
        //     lng: longitude!,
        //   );
        //   _localities!.add(loc);
        //
        // }
        // print('Controller Print : ${_localities![0].name}');

        update();  // Update the UI
        ///

      }
    }
  }
}
