// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class PropertyMapController extends GetxController {
//   GoogleMapController? mapController;
//   double? latitude;
//   double? longitude;
//   RxBool isLoading = false.obs; // Loading indicator
//
//   PropertyMapController({required this.latitude, required this.longitude});
//
//   void onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     updateMapCamera();
//     update();
//   }
//
//   void updateMapCamera() {
//     if (mapController != null && latitude != null && longitude != null) {
//       mapController!.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(latitude!, longitude!),
//         ),
//       );
//     }
//     update();
//   }
// }
