

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/map_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/Maps/widgets/map_property_bottomsheet.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class PropertiesMapScreen extends StatelessWidget {
  final String purposeId;
  final String propertyTypeId;
  const PropertiesMapScreen({Key? key, required this.purposeId, required this.propertyTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());
    mapController.setPurposeID(purposeId);
    mapController.setPropertyTypeID(propertyTypeId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Properties"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            Get.find<PropertyController>().getPropertyList(page: '1');
          },
        ),
      ),
      body: GetBuilder<MapController>(
        builder: (locationControl) {
          if (locationControl.markerCoordinates.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: locationControl.onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(22.5726, 88.3639), // Default center for Kolkata, West Bengal
                  zoom: 12.0, // Adjust zoom level as needed
                ),
                markers: locationControl.markerCoordinates.map((coord) {
                  return Marker(
                    markerId: MarkerId(coord.toString()),
                    position: coord,
                  );
                }).toSet(),
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
                        if (locationControl.selectedLatitude != null &&
                            locationControl.selectedLongitude != null) {
                          if (!locationControl.isWithinWestBengal(
                              locationControl.selectedLatitude!,
                              locationControl.selectedLongitude!)) {
                            // Show Snackbar indicating server is not available outside West Bengal
                            Get.snackbar(
                              'Server Not Available',
                              'The server is not available outside West Bengal, India.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          Get.bottomSheet(
                            MapPropertySheet(
                              lat: locationControl.selectedLatitude.toString(),
                              long: locationControl.selectedLongitude.toString(),
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
                      },
                    ),
                    sizedBox10(),
                     Text('Note : Currently We are only available in West Bengal ',
                       style: senRegular.copyWith(color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,),
                  ],
                ),
              ),
              Positioned(
                bottom: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.find<PropertyController>().getPropertyList(
                        //   page: '1',
                        //   lat: locationControl.selectedLatitude.toString(),
                        //   long: locationControl.selectedLongitude.toString(),
                        // );
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSize40,
                          vertical: Dimensions.fontSize18,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Text(
                          '← Save Location',
                          style: TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Theme.of(context).cardColor,
                      onPressed: () {
                        if (!locationControl.isWithinWestBengal(
                            locationControl.lat ?? 0, locationControl.long ?? 0)) {
                          // Show Snackbar indicating server is not available outside West Bengal
                          Get.snackbar(
                            'Server Not Available',
                            'The server is not available outside West Bengal, India.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        Get.bottomSheet(
                          MapPropertySheet(
                            lat: locationControl.lat.toString(),
                            long: locationControl.long.toString(),
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
                      },
                      child: Icon(
                        Icons.apartment,
                        color: Theme.of(context).primaryColor,
                      ),
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
