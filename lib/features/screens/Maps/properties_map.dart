import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/map_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/Maps/widgets/map_property_bottomsheet.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../controller/auth_controller.dart';

class PropertiesMapScreen extends StatelessWidget {
  final String purposeId;
  final String propertyTypeId;

  const PropertiesMapScreen({
    Key? key,
    required this.purposeId,
    required this.propertyTypeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.setPurposeID(purposeId);
      mapController.setPropertyTypeID(propertyTypeId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Properties"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<MapController>(
        builder: (locationControl) {
          // if (locationControl.markerCoordinates.isEmpty) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: locationControl.onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(22.5726, 88.3639),
                  zoom: 12.0,
                ),
                markers: locationControl.markerCoordinates.map((coord) {
                  return Marker(
                    markerId: MarkerId(coord.toString()),
                    position: coord,
                    infoWindow: InfoWindow(
                      title: locationControl.markerNames[coord] ?? 'No Name',
                    ),
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
                            Get.snackbar(
                              'Server Not Available',
                              'The server is not available outside West Bengal, India.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                        }
                      },
                    ),
                    sizedBox10(),
                    Text(
                      'Note: Currently, we are only available in West Bengal',
                      style: senRegular.copyWith(fontSize: 12),
                    ),
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
                    Flexible(
                      child: CustomButtonWidget(
                        onPressed: () {
                          if (locationControl.selectedLatitude == null || locationControl.selectedLongitude == null ) {
                            Get.back();

                          } else {
                            Get.find<AuthController>().saveExploreLatitude(locationControl.selectedLatitude!);
                            Get.find<AuthController>().saveExploreLongitude(locationControl.selectedLongitude!);
                            Get.find<PropertyController>().getExplorePropertyList(page: '1',
                              lat:  locationControl.selectedLatitude.toString(),
                              long: locationControl.selectedLongitude.toString(),
                            );
                            Get.back();

                          }

                        },
                        buttonText: 'Save',
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
