import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../controller/auth_controller.dart';
import '../controller/property_controller.dart';

class MapController extends GetxController {
  GoogleMapController? mapController;
  double? lat;
  double? long;
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

  List<LatLng> markerCoordinates = [];
  RxList<Map<String, String>> suggestions = <Map<String, String>>[].obs;
  RxMap<LatLng, String> markerNames = <LatLng, String>{}.obs;

  String apiKey = 'AIzaSyBNB2kmkXSOtldNxPdJ6vPs_yaiXBG6SSU';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitialProperties();
    });
  }

  Future<void> fetchInitialProperties() async {
    double? latitude = Get.find<AuthController>().getExploreLatitude();
    double? longitude = Get.find<AuthController>().getExploreLongitude();

    if (latitude == null || longitude == null) {
      Get.find<PropertyController>().getPropertyLatLngList(
        page: '1',
        distance: '10',
      );
    } else {
      Get.find<PropertyController>().getPropertyLatLngList(
        page: '1',
        lat: latitude.toString(),
        long: longitude.toString(),
      );
    }
    updateMarkerCoordinates();
  }

  Future<void> updateMarkerCoordinates() async {
    markerCoordinates = Get.find<PropertyController>().markerCoordinates;
    markerNames.clear(); // Clear existing names
    var propertyList = Get.find<PropertyController>().propertyLatList;
    if (propertyList != null) {
      for (var property in propertyList) {
        double latitude = property.latitude ?? 0;
        double longitude = property.longitude ?? 0;
        markerNames[LatLng(latitude, longitude)] = property.title ?? 'No Name';
      }
    }
    update();
    focusOnMarkers();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    focusOnMarkers();
  }

  void focusOnMarkers() {
    if (mapController != null && markerCoordinates.isNotEmpty) {
      if (markerCoordinates.length == 1) {
        // If there's only one marker, focus on it with a zoom level
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: markerCoordinates.first,
              zoom: 14.0, // Adjust the zoom level to your preference
            ),
          ),
        );
      } else {
        // If there are multiple markers, calculate the bounds
        LatLngBounds bounds = getBounds();
        mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
      }
    }
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

    lat = (minLat + maxLat) / 2;
    long = (minLong + maxLong) / 2;

    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  Future<void> fetchSuggestions(String query) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

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
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['result']['geometry']['location'];
        selectedLatitude = location['lat'];
        selectedLongitude = location['lng'];

        await Get.find<PropertyController>().getPropertyLatLngList(
          page: '1',
          distance: '10',
          lat: selectedLatitude.toString(),
          long: selectedLongitude.toString(),
        );

        updateMarkerCoordinates();
      }
    }
  }


  bool isWithinWestBengal(double lat, double long) {
    double minLat = 21.5422;
    double maxLat = 27.6217;
    double minLong = 85.5301;
    double maxLong = 89.3014;

    return (lat >= minLat && lat <= maxLat && long >= minLong && long <= maxLong);
  }
}
