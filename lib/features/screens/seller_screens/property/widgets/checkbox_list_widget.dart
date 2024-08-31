// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_my_properties/controller/auth_controller.dart';
// import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
// import 'package:get_my_properties/features/widgets/custom_app_button.dart';
// import 'package:get_my_properties/utils/dimensions.dart';
// import 'package:get_my_properties/utils/sizeboxes.dart';
//
// class FilterCategoryScreen extends StatelessWidget {
//   final String filterType;
//
//   FilterCategoryScreen({super.key, required this.filterType});
//
//   final stateController = TextEditingController();
//   final districtController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<AuthController>().getHomeDataApi();
//     });
//
//     return Scaffold(
//       appBar: const CustomAppBar(
//         title: "",
//         isBackButtonExist: true,
//       ),
//       bottomNavigationBar: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           child: CustomButtonWidget(
//             buttonText: 'Save',
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//       ),
//       body: GetBuilder<AuthController>(builder: (authControl) {
//         return authControl.homeData!.propertyAmenities!.isEmpty  ?
//           Container(
//           height: Get.size.height * 0.8,
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(Dimensions.radius15),
//           ),
//           child: const Center(child: CircularProgressIndicator()),
//
//         ):
//         Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: authControl.homeData!.propertyAmenities!.length,
//                 itemBuilder: (context, index) {
//                   final state = authControl.homeData!.propertyAmenities![index];
//                   final isSelected = authControl.filterPostingState.contains(state);
//
//                   return CheckboxListTile(
//                     title: Text(
//                       state,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
//                       ),
//                     ),
//                     value: isSelected,
//                     onChanged: (bool? selected) {
//                       // authControl.setFilterPostingState(state);
//                       // print(authControl.filterPostingState); // Debug print
//                     },
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         );
//
//
//       }),
//     );
//   }
// }
