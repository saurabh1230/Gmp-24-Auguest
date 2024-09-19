import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/profile_controller.dart';
import 'package:get_my_properties/features/screens/Maps/location_view.dart';
import 'package:get_my_properties/features/screens/Maps/vendor_map_view.dart';
import 'package:get_my_properties/features/screens/dashboard/dashboard.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatelessWidget {
  final bool? isBackButton;
  ProfileScreen({super.key, this.isBackButton = false});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _registerTypeController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _websiteController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().isCustomerLoggedIn() ?
      Get.find<AuthController>().profileDetailsApi() :
      Get.find<AuthController>().profileDetailsApi(isVendor : true);
      Get.find<ProfileController>().pickImage(isRemove: true);
    });
    return Scaffold(
        key: _scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: isBackButton! ? IconButton(
            icon:  const Icon(Icons.arrow_back),
            color: Theme.of(context).cardColor,
            onPressed: () =>  Navigator.pop(context),
          ) :
          InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Image.asset(Images.drawerMenuIcon,height: 24,width: 24,),
            ),
          ) ,
          title:Text("Profile",style: senRegular.copyWith(fontSize: Dimensions.fontSize18, color: Theme.of(context).cardColor),) ,
          actions: [Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
            child: CustomNotificationButton(
              tap: () {
                Get.toNamed(RouteHelper.getNotificationRoute());
              },
            ),
          )],
        ),
        body: GetBuilder<AuthController>(builder: (authControl) {
          return authControl.profileData == null || authControl.profileDetailsLoading ?
              const Center(child: CircularProgressIndicator()) :

           GetBuilder<ProfileController>(builder: (profileControl) {
            _nameController.text = authControl.profileData?.name?.toString() ?? '';
            _addressController.text = authControl.profileData?.address?.toString() ?? '';
            _emailController.text = authControl.profileData?.email?.toString() ?? '';
            _phoneController.text = authControl.profileData?.phoneNumber?.toString() ?? '';
            _registerTypeController.text = authControl.profileData?.userType?.toString() ?? '';


            if(authControl.profileData!.userType == "vender") {
              _nameController.text = authControl.profileData?.name?.toString() ?? '';
              _usernameController.text = authControl.profileData?.username?.toString() ?? '';

            } else {


            }


            return  Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(height: 100,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              )
                          ),),
                        Container(
                          height: 80,
                        ),
                      ],
                    ),
                    Positioned(bottom: 0,left: 0,right: 0,
                      child: Center(
                        child: Stack(
                          children:[ Container(
                            height: 150, width: 150,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                              border: Border.all(width: 0.5,
                                color: Theme.of(context).primaryColor.withOpacity(0.40),),
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                            ),
                            // alignment: Alignment.center,
                            child:profileControl.pickedImage != null ? Image.file(
                              File(profileControl.pickedImage!.path,),height: 90, width: 90,  fit: BoxFit.cover,
                            ): Stack(
                              children: [
                                Container(
                                    height: 150, width: 150,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    ),
                                    child:
                                      CustomNetworkImageWidget(
                                       imagePadding: Dimensions.paddingSize40,
                                      height: 150, width: 150,
                                       image: '${AppConstants.imgProfileBaseUrl}${authControl.profileData!.profileImage!.toString()}',
                                       placeholder: Images.profilePlaceholder,
                                      fit: BoxFit.cover,)
                                ),
                                // Image.asset(Images.profilePlaceholder,)
                              ],
                            ),
                          ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              top: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () => profileControl.pickImage(isRemove: false),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Theme.of(context).primaryColor),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Colors.white),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.camera_alt, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            showTitle: true,
                            hintText: "Name",
                            editText: true,),
                          authControl.profileData!.userType == "customer" ?
                          const SizedBox() :
                          Column(
                            children: [
                              sizedBoxDefault(),
                              CustomTextField(
                                controller: _usernameController,
                                showTitle: true,
                                hintText: "Username",
                                editText: true,),
                              sizedBoxDefault(),
                               // CustomTextField(
                               //  controller: _stateController,
                               //  showTitle: true,
                               //  hintText: "State",
                               //  editText: true,),
                              // sizedBoxDefault(),
                              // Row(
                              //   children: [
                              //      Expanded(
                              //       child: CustomTextField(
                              //         controller: _cityController,
                              //         showTitle: true,
                              //         hintText: "City",
                              //         editText: false,),
                              //     ),
                              //     sizedBoxW10(),
                              //      Expanded(
                              //       child: CustomTextField(
                              //         controller: _zipcodeController,
                              //         inputType: TextInputType.number,
                              //         showTitle: true,
                              //         hintText: "Zip-Code",
                              //         editText: false,),
                              //     ),
                              //   ],
                              // ),

                            ],
                          ),
                          sizedBoxDefault(),
                          authControl.profileData!.userType == "customer" ?
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Address',
                                // Adjust style as needed
                              ),
                              const SizedBox(height: 5 ),
                              CustomTextField(
                                onTap: () {
                                  // Get.to(() => const VendorMapView());
                                  // Get.to(LocationPickerScreen(isAddress: true,));
                                  // Get.toNamed(RouteHelper.getLocationPickerRoute(isAddress: true));
                                },
                                controller: _addressController,
                                // readOnly: true,
                                // showTitle: true,
                                maxLines: 4,
                                hintText: authControl.getSaveAddress().toString().isEmpty ?
                                '' :
                                authControl.getSaveAddress().toString(),
                                editText: true,),
                            ],
                          ):
                          CustomTextField(
                            controller: _addressController,
                            showTitle: true,
                            maxLines: 4,
                            hintText: "Address",
                            editText: true,),
                          authControl.profileData!.userType == "customer" ?
                          const SizedBox() :
                          Column(
                            children: [
                              sizedBoxDefault(),
                              const CustomTextField(
                                showTitle: true,
                                hintText: "Website Link",
                                editText: true,),
                            ],
                          ),
                          sizedBoxDefault(),
                          Align(alignment: Alignment.centerLeft,
                              child: Text("Sign In & Security",style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).primaryColor),)),
                          sizedBox4(),
                          CustomTextField(
                            readOnly: true,
                            controller: _registerTypeController,
                            showTitle: true,
                            hintText: "Registered As (non editable)",
                            editText: false,),
                          sizedBoxDefault(),
                          CustomTextField(
                            controller: _emailController,
                            showTitle: true,
                            hintText: "Email Address",
                            editText: true,),
                          sizedBoxDefault(),
                          CustomTextField(
                            controller: _phoneController,
                            isAmount: true,
                            isNumber: true,
                            readOnly: true,
                            showTitle: true,
                            hintText: "Phone No (non editable)",
                            editText: false,),
                          sizedBoxDefault(),
                          /*const CustomTextField(
                        showTitle: true,
                        hintText: "Password",
                        isPassword: true,),
                      sizedBoxDefault(),*/
                          // OutlinedButton(onPressed: () {
                          //   // Get.toNamed(RouteHelper.getSavedRoute(isBackButton: true));
                          // }, child: Padding(
                          //   padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSize12),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text("History",style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).disabledColor),),
                          //       const Icon(Icons.arrow_forward)
                          //
                          //     ],
                          //   ),
                          // )),
                          sizedBox20(),
                          profileControl.isLoading ?
                          const CircularProgressIndicator() :
                          CustomButtonWidget(
                            buttonText: 'Save',
                            onPressed: () {
                              if(authControl.isCustomerLoggedIn()) {
                                profileControl.updateProfile(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  address: _addressController.text,
                                  image: profileControl.pickedImage != null && profileControl.pickedImage!.path.isNotEmpty
                                      ? profileControl.pickedImage
                                      : null,);
                                // Get.toNamed(RouteHelper.getDashboardRoute());
                              } else {
                                profileControl.updateVendorProfile(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  address: _addressController.text,
                                  image: profileControl.pickedImage != null && profileControl.pickedImage!.path.isNotEmpty
                                      ? profileControl.pickedImage
                                      : null,
                                  username: _usernameController.text,
                                  websiteUrl: '',);


                              }


                            },),
                          sizedBox20(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });





        })





    );
  }
}
