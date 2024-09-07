import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_my_properties/data/models/body/vendor_locality.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:get_my_properties/controller/vendor_map_controller.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';

class VendorMapView extends StatelessWidget {
  const VendorMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Location',isBackButtonExist: true,),
      body: GetBuilder<VendorMapController>(
        builder: (locationControl) {
          if (locationControl.latitude == null || locationControl.longitude == null) {
            return const Center(child: CircularProgressIndicator());
          }
          LatLng center = LatLng(locationControl.latitude!, locationControl.longitude!);
          return Stack(
            children: [
              GoogleMap(
                mapToolbarEnabled: false,
                onMapCreated: locationControl.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: center,
                  ),
                },
                onCameraMove: (CameraPosition position) {
                  locationControl.latitude = position.target.latitude;
                  locationControl.longitude = position.target.longitude;
                  locationControl.setMainLat(position.target.latitude);
                  locationControl.setMainLng(position.target.longitude);
                  locationControl.updateAddress(); // Update address on camera move
                  locationControl.update();  // Notify listeners to update UI
                },
              ),
              Positioned(
                top: 10,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          hintText: 'Search Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        await locationControl.fetchSuggestions(pattern);
                        return locationControl.suggestions.toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion['description'] ?? ''),
                        );
                      },
                      onSuggestionSelected: (suggestion) async {
                        String placeId = suggestion['place_id'] ?? '';
                        await locationControl.fetchLocationDetails(placeId);
                        if (locationControl.latitude != null &&
                            locationControl.longitude != null) {
                          locationControl.mapController?.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(locationControl.latitude!, locationControl.longitude!),
                            ),
                          );
                        }
                      },
                    ),
                    Text('Search Location by Locality',style: senRegular.copyWith(color: Theme.of(context).disabledColor),)
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Text(
                        locationControl.address ?? 'Fetching address...',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    sizedBoxDefault(),
                    CustomButtonWidget(
                      buttonText: 'Continue',
                      onPressed: () {
                        // For demonstration, printing the list of localities
                        print(locationControl.localities[0].name);
                        print(locationControl.localities[0].lat);
                        print(locationControl.localities[0].lng);

                        // Example of how to use the locality data:
                        // if (locationControl.localities.isNotEmpty) {
                        //   LocalityMapData selectedLocality = locationControl.localities.last;
                        //   print('Selected Locality: ${selectedLocality.name}, Lat: ${selectedLocality.lat}, Lng: ${selectedLocality.lng}');
                        // }

                        Get.back();

                        // Get.find<AuthController>().saveLatitude(latitude);
                        // Get.find<AuthController>().saveLongitude(longitude);
                        // Get.find<AuthController>().saveAddress(locationControl.address ?? '');
                        // Get.offNamed(RouteHelper.getDashboardRoute());
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
