// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:get_my_properties/controller/vendor_map_controller.dart';
// import 'package:get_my_properties/utils/sizeboxes.dart';
//
// class AddPropertyMapView extends StatelessWidget {
//   const AddPropertyMapView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<VendorMapController>(
//       builder: (locationControl) {
//         final double latitude = locationControl.latitude ?? 0.0;
//         final double longitude = locationControl.longitude ?? 0.0;
//         final LatLng center = LatLng(latitude, longitude);
//
//         return Stack(
//           children: [
//             GoogleMap(
//               mapToolbarEnabled: false,
//               onMapCreated: locationControl.onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: center,
//                 zoom: 14.0,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId('currentLocation'),
//                   position: center,
//                 ),
//               },
//               onCameraMove: (CameraPosition position) {
//                 locationControl.latitude = position.target.latitude;
//                 locationControl.longitude = position.target.longitude;
//                 locationControl.updateAddress(); // Update address on camera move
//                 locationControl.update();  // Notify listeners to update UI
//               },
//             ),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     color: Colors.white,
//                     child: Text(
//                       locationControl.address ?? 'Fetching address...',
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   sizedBoxDefault(),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
