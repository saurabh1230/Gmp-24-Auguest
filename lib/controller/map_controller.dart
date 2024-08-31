import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/Maps/widgets/map_property_bottomsheet.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  double? lat; // Latitude to be used for API call
  double? long; // Longitude to be used for API call
  double? selectedLatitude;
  double? selectedLongitude;
  String? address;

  String _purposeId = '';
  String get purposeId => _purposeId;
  void setPurposeID(String val) {
    _purposeId = val;
    update();
  }

  String _propertyTypeId = '';
  String get propertyTypeId => _propertyTypeId;
  void setPropertyTypeID(String val) {
    _propertyTypeId = val;
    update();
  }

  List<LatLng> markerCoordinates = Get.find<PropertyController>().markerCoordinates;

  // Check if the given location is within West Bengal
  bool isWithinWestBengal(double lat, double long) {
    // Define the bounding box for West Bengal
    double minLat = 21.5422;
    double maxLat = 27.6217;
    double minLong = 85.5301;
    double maxLong = 89.3014;

    return (lat >= minLat && lat <= maxLat && long >= minLong && long <= maxLong);
  }

  LatLngBounds getBounds() {
    double minLat = markerCoordinates[0].latitude;
    double maxLat = markerCoordinates[0].latitude;
    double minLong = markerCoordinates[0].longitude;
    double maxLong = markerCoordinates[0].longitude;

    for (LatLng coord in markerCoordinates) {
      if (coord.latitude < minLat) minLat = coord.latitude;
      if (coord.latitude > maxLat) maxLat = coord.latitude;
      if (coord.longitude < minLong) minLong = coord.longitude;
      if (coord.longitude > maxLong) maxLong = coord.longitude;
    }

    LatLng southwest = LatLng(minLat, minLong);
    LatLng northeast = LatLng(maxLat, maxLong);

    // Calculate center coordinates
    double centerLat = (minLat + maxLat) / 2;
    double centerLong = (minLong + maxLong) / 2;

    lat = centerLat; // Set the center latitude
    long = centerLong; // Set the center longitude

    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  @override
  void onInit() {
    super.onInit();
    focusOnMarkers(); // Only focus on the initial markers
  }

  void focusOnMarkers() {
    if (mapController != null && markerCoordinates.isNotEmpty) {
      LatLngBounds bounds = getBounds();

      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      Get.bottomSheet(
        MapPropertySheet(
          lat: lat.toString(),
          long: long.toString(),
          purposeId: _purposeId,
          propertyTypeId: _propertyTypeId,

        ),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20),
          ),
        ),
      );
    }
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
    focusOnMarkers(); // Focus on markers when the map is created
  }

  // API key for Google Places API
  String apiKey = 'AIzaSyBNB2kmkXSOtldNxPdJ6vPs_yaiXBG6SSU'; // Replace with your Google API key
  RxList<Map<String, String>> suggestions = <Map<String, String>>[].obs;

  Future<void> fetchSuggestions(String query) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Log API response
      if (data['status'] == 'OK') {
        final List<dynamic> predictions = data['predictions'];
        suggestions.value = predictions.map((prediction) {
          return {
            'description': prediction['description'] as String,
            'place_id': prediction['place_id'] as String,
          };
        }).toList();

        // Check if the first suggestion is within West Bengal
        if (predictions.isNotEmpty) {
          String placeId = predictions[0]['place_id'] ?? '';
          await fetchLocationDetails(placeId);
          if (!isWithinWestBengal(selectedLatitude ?? 0, selectedLongitude ?? 0)) {
            // Clear suggestions if outside West Bengal
            suggestions.value = [];
            // Show Snackbar indicating server is not available outside West Bengal
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(
                content: Text(
                  'The server is not available outside West Bengal, India.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
            // snackbarShown = true; // Set flag to true after showing Snackbar
          }
        }
      } else {
        suggestions.value = [];
      }
    } else {
      suggestions.value = [];
    }
  }

  Future<void> fetchLocationDetails(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];
        selectedLatitude = location['lat'];
        selectedLongitude = location['lng'];
        print('Selected Latitude: $selectedLatitude');
        print('Selected Longitude: $selectedLongitude');

        update(); // Update the UI
      }
    }
  }
}
