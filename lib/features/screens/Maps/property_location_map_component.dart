import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_my_properties/controller/location_controller.dart';

class PropertyLocationMapComponent extends StatelessWidget {
  final double? longitude;
  final double? latitude;

  const PropertyLocationMapComponent({
    Key? key,
    this.longitude,
    this.latitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: GetBuilder<LocationController>(
        builder: (locationController) {
          LatLng center = LatLng(
            latitude ?? locationController.latitude ?? 0.0,
            longitude ?? locationController.longitude ?? 0.0,
          );

          return GoogleMap(
            // mapToolbarEnabled: false,
            // zoomGesturesEnabled: true,
            // zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('currentLocationMarker'),
                position: center,
                infoWindow: InfoWindow(
                  title: 'Current Location',
                ),
              ),
            },
            // onMapCreated: (GoogleMapController controller) {
            //   locationController.onMapCreated(controller);
            //
            //   // Animate camera to the location if coordinates are available
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     if (latitude != null && longitude != null) {
            //       controller.animateCamera(CameraUpdate.newLatLng(center));
            //     }
            //   });
            // },
          );
        },
      ),
    );
  }
}
