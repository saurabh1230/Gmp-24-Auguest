import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/data/models/response/country_state_city_model.dart';
import 'package:get_my_properties/data/models/response/locality_model.dart';
import 'package:get_my_properties/data/models/response/property_detail_model.dart';
import 'package:get_my_properties/data/models/response/property_model.dart';
import 'package:get_my_properties/data/repo/location_repo.dart';
import 'package:get_my_properties/data/repo/property_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_places_flutter/google_places_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo,});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  String ? _countryId;
  String? get countryId => _countryId;
  void setCountryId(String val) {
    _countryId = val;
    update();
  }

  String ? _stateId;
  String? get stateId => _stateId;
  void setStateId(String val) {
    _stateId = val;
    update();
  }

  String ? _cityId;
  String? get cityId => _cityId;
  void setCityId(String val) {
    _cityId = val;
    update();
  }
  String? _localityId;
  String? get localityId => _localityId;
  void setLocalityId(String val) {
    _localityId = val;
    update();
  }


  List<LocationModel>? _countryList;
  List<LocationModel>? get countryList => _countryList;
  Future<void> getCountryList() async {
    _isLoading = true;
    update();
    try {
      Response response = await locationRepo.getCountryRepo();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _countryList = responseData.map((json) => LocationModel.fromJson(json)).toList();
      } else {
       print("Errror in Country Load");
      }
    } catch (error) {
      print("Error while fetching Country  list: $error");
    }
    _isLoading = false;
    update();
  }

  List<LocationModel>? _stateList;
  List<LocationModel>? get stateList => _stateList;
  Future<void> getStateList() async {
    _isLoading = true;
    update();
    try {
      Response response = await locationRepo.getStateRepo();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _stateList = responseData.map((json) => LocationModel.fromJson(json)).toList();
        if (stateList!.isNotEmpty ) {
          _stateId = stateList![0].id;
        }
      } else {
        print("Errror in Country Load");
      }
    } catch (error) {
      print("Error while fetching Country  list: $error");
    }
    _isLoading = false;
    update();
  }

  List<LocalityModel>? _localityList;
  List<LocalityModel>? get localityList => _localityList;
  Future<void> getLocalityList() async {
    _isLoading = true;
    update();
    try {
      Response response = await locationRepo.getLocalityRepo();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _localityList = responseData.map((json) => LocalityModel.fromJson(json)).toList();
        if (localityList!.isNotEmpty ) {
          _localityId = localityList![0].id;
        }
      } else {
        print("Errror in Country Load");
      }
    } catch (error) {
      print("Error while fetching Country  list: $error");
    }
    _isLoading = false;
    update();
  }

  List<LocationModel>? _cityList;
  List<LocationModel>? get cityList => _cityList;

  Future<void> getCityList(String? stateId) async {
    _isLoading = true;
    update();
    try {
      Response response = await locationRepo.getCityRepo(stateId);
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _cityList = responseData.map((json) => LocationModel.fromJson(json)).toList();
        if (cityList!.isNotEmpty ) {
          _cityId = cityList![0].id;
        }
      } else {
        print("Error in Country Load");
      }
    } catch (error) {
      print("Error while fetching Country  list: $error");
    }
    _isLoading = false;
    update();
  }


  /// Google maps ///



  // GoogleMapController? mapController;
  // double? latitude;
  // double? longitude;
  // String? address;
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getUserLocation();
  // }
  //
  // Future<void> getUserLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return;  // Handle if location services are not enabled
  //   }
  //
  //   // Check for location permissions
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     return;  // Handle if permission is permanently denied
  //   }
  //
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       return;  // Handle if permission is denied
  //     }
  //   }
  //
  //   // Get current position
  //   Position currentPosition = await Geolocator.getCurrentPosition();
  //
  //   latitude = currentPosition.latitude;
  //   longitude = currentPosition.longitude;
  //   print(latitude);
  //   print(longitude);
  //
  //   // Convert coordinates to address
  //   await updateAddress();
  //
  //   // Notify listeners to rebuild the UI
  //   update();
  // }
  //
  // Future<void> updateAddress() async {
  //   if (latitude != null && longitude != null) {
  //     try {
  //       List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
  //       if (placemarks.isNotEmpty) {
  //         Placemark placemark = placemarks.first;
  //         address = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
  //         print(address);
  //       }
  //     } catch (e) {
  //       print("Error occurred while converting coordinates to address: $e");
  //     }
  //   }
  // }
  //
  // Future<void> searchLocation(String query) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(query);
  //     if (locations.isNotEmpty) {
  //       latitude = locations.first.latitude;
  //       longitude = locations.first.longitude;
  //       await updateAddress();
  //       if (mapController != null) {
  //         mapController!.animateCamera(
  //           CameraUpdate.newLatLng(
  //             LatLng(latitude!, longitude!),
  //           ),
  //         );
  //       }
  //       update();  // Notify listeners to update UI
  //     }
  //   } catch (e) {
  //     print("Error occurred while searching for location: $e");
  //   }
  // }
  //
  // void onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  //   update();
  //   if (latitude != null && longitude != null) {
  //     mapController?.animateCamera(
  //       CameraUpdate.newLatLng(
  //         LatLng(latitude!, longitude!),
  //       ),
  //     );
  //   }
  // }
  GoogleMapController? mapController;
  double? latitude;
  double? longitude;
  String? address;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;  // Handle if location services are not enabled
    }

    // Check for location permissions
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

    // Get current position
    Position currentPosition = await Geolocator.getCurrentPosition();

    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
    print(latitude);
    print(longitude);

    // Convert coordinates to address
    await updateAddress();

    // Notify listeners to rebuild the UI
    update();
  }

  Future<void> updateAddress() async {
    if (latitude != null && longitude != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          address = '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
          print(address);
        }
      } catch (e) {
        print("Error occurred while converting coordinates to address: $e");
      }
    }
  }



  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
    if (latitude != null && longitude != null) {
      mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitude!, longitude!),
        ),
      );
    }
  }




}






