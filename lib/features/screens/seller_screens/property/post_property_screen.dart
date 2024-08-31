
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/explore_controller.dart';
import 'package:get_my_properties/controller/location_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/controller/vendor_map_controller.dart';
import 'package:get_my_properties/data/models/response/home_data_model.dart';
import 'package:get_my_properties/features/screens/Maps/vendor_map_view.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/dashboard/seller_dashboard.dart';
import 'package:get_my_properties/features/screens/seller_screens/property/widgets/add_property_map_view.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_dropdown_button.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/features/widgets/multiple_data_field.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import '../../../../utils/images.dart';
import '../../../../utils/sizeboxes.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class PostPropertyScreen extends StatelessWidget {
  final bool? isBackButton;
   PostPropertyScreen({super.key,  this.isBackButton = false});
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _descController = TextEditingController();
   final TextEditingController _metaTitleController = TextEditingController();
   final TextEditingController _metaDescController = TextEditingController();
   final TextEditingController _addressController = TextEditingController();
   final TextEditingController _slugController = TextEditingController();
   final TextEditingController _videoLinkController = TextEditingController();
   final TextEditingController _priceController = TextEditingController();
   final TextEditingController _marketPriceController = TextEditingController();
   final TextEditingController _areaController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   // GetX Controllers
   final AuthController _authController = Get.find<AuthController>();
   final LocationController _locationController = Get.find<LocationController>();
   final VendorMapController _vendorMapController = Get.find<VendorMapController>();
   final PropertyController _propertyController = Get.find<PropertyController>();
   final ExploreController _exploreController = Get.find<ExploreController>();


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getHomeDataApi();
      Get.find<LocationController>().getCountryList();
      Get.find<LocationController>().getStateList();
      Get.find<LocationController>().getCityList('66b356ec18a20385edf487c2');
      Get.find<LocationController>().getLocalityList();
    });
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar:  CustomAppBar(title: "Post Property",isBackButtonExist: isBackButton == true  ? true : false ,),
      body: GetBuilder<VendorMapController>(builder: (vendorMapController) {
        _addressController.text = vendorMapController.address ?? 'Add Address';
        return  GetBuilder<AuthController>(builder: (authControl) {
          final data = authControl.homeData;
          final list = data == null  || authControl.homeData!.propertyTypes == null ||
              authControl.homeData!.propertyTypes!.isEmpty;
          return list ?
          const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            child: GetBuilder<PropertyController>(builder: (propertyController) {
              return  GetBuilder<ExploreController>(builder: (controller) {
                return   GetBuilder<LocationController>(builder: (locationControl) {
                    final data = locationControl.stateList;
                    final list = data == null  || authControl.homeData!.propertyTypes == null ||
                        authControl.homeData!.propertyTypes!.isEmpty;
                    return list ?
                    const Center(child: CircularProgressIndicator()) : Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,horizontal: Dimensions.paddingSizeDefault),
                      child: Form(key: _formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Property Details", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),),
                            sizedBox10(),
                            sizedBoxDefault(),
                            CustomTextField(
                              maxLines: 3, controller: _titleController,
                              showTitle: true, hintText: "Title ",
                              capitalization: TextCapitalization.words, validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Property Title';
                                }
                                return null;
                              },
                            ),
                            sizedBoxDefault(),
                            CustomTextField(
                              controller: _descController, maxLines: 5,
                              showTitle: true, hintText: "Description ",
                              capitalization: TextCapitalization.words, validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Property Description';
                                }
                                return null;
                              },
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _priceController, inputType: TextInputType.number,
                                    showTitle: true, hintText: "Price in ₹",
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Property Price';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                sizedBoxW10(),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _marketPriceController, inputType: TextInputType.number,
                                    showTitle: true, hintText: "Market Price in ₹ ",
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Property Market Price';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: _areaController, inputType: TextInputType.number,
                                    showTitle: true, hintText: "Area In Square Feet",
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Add Square Feet';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                sizedBoxW10(),
                                Expanded(
                                  child: CustomTextField(
                                    onTap: () {
                                      Get.dialog(controller.yearPicker("Pick Build Year of Property",isBuildYear: true));
                                    },
                                    controller: controller.buildYearController, inputType: TextInputType.number,
                                    showTitle: true, hintText: "Build Year",
                                    readOnly: true,
                                    validation: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Add Build Year';
                                      }
                                      return null;
                                    },


                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Rooms",
                                        style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                                      ),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Room';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Room', items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectRoomDigit(value);
                                            print(controller.roomDigit);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                sizedBoxW10(),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bedroom", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Bedroom';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Bedroom', items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectBedroomDigit(value);
                                            print(controller.bedroomDigit);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Bathroom", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Bathroom';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Bathroom',
                                        items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectBathroomDigit(value);
                                            print(controller.bathroomDigit);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                sizedBoxW10(),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Kitchen", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                                      ),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Kitchens';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Kitchens', items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectKitchenDigit(value);
                                            print(controller.kitchenDigit);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Floors", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                                      ),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Floors';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Floors',
                                        items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectFloorDigit(value);
                                            print(controller.floorDigit);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                sizedBoxW10(),
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Space in Bhk", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),),
                                      sizedBox10(),
                                      CustomDropdown<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Add Space';
                                          }
                                          return null;
                                        },
                                        hintText: 'Add Space', items:  controller.roomList,
                                        onChanged: (value) {
                                          if (value != null) {
                                            controller.selectSpaceDigit(value);
                                            print(controller.spaceDigit);
                                          }
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sizedBoxDefault(),
                            Text("Unit", style: senRegular.copyWith(fontSize: Dimensions.fontSize15),),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Unit';
                                }
                                return null;
                              },
                              hintText: 'Add Unit', items:  controller.roomList,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectUnitDigit(value);
                                  print(controller.unitDigit);
                                }
                              },
                            ),

                            sizedBoxDefault(),
                            CustomTextField(controller: _metaTitleController,
                              maxLines: 1, showTitle: true,
                              hintText: "Meta Title ", capitalization: TextCapitalization.words,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Meta Title';
                                }
                                return null;
                              },
                            ),
                            sizedBoxDefault(),
                            CustomTextField(
                              controller: _metaDescController,
                              maxLines: 2, showTitle: true,
                              hintText: "Meta Description ", capitalization: TextCapitalization.words,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Meta Description';
                                }
                                return null;
                              },),
                            sizedBoxDefault(),
                            CustomTextField(
                              controller: _slugController, maxLines: 1,
                              showTitle: true, hintText: "Slug",
                              capitalization: TextCapitalization.words,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Slug';
                                }
                                return null;
                              },),
                            sizedBoxDefault(),
                            CustomTextField(
                              controller: _videoLinkController, maxLines: 1,
                              showTitle: true, hintText: "Video Link",
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Type",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Property Type';
                                }
                                return null;
                              },
                              hintText: 'Property Type',
                              items: authControl.homeData!.propertyTypes!
                                  .map((purpose) => purpose.name!)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = authControl.homeData!.propertyTypes!
                                      .firstWhere((purpose) => purpose.name == value);
                                  authControl.selectPropertyTypeId(selectedPurpose.sId.toString());
                                  print(authControl.propertyTypeID);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Purpose",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a purpose';
                                }
                                return null;
                              },
                              hintText: 'Select Purpose',
                              items: authControl.homeData!.propertyPurposes!
                                  .map((purpose) => purpose.name!)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = authControl.homeData!.propertyPurposes!
                                      .firstWhere((purpose) => purpose.name == value);
                                  authControl.selectPropertyPurposeId(selectedPurpose.sId.toString());
                                  print(authControl.propertyPurposeID);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Category",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a Property Type';
                                }
                                return null;
                              },
                              hintText: 'Property Type',
                              items: authControl.homeData!.propertyCategory!
                                  .map((purpose) => purpose.name!)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = authControl.homeData!.propertyCategory!
                                      .firstWhere((purpose) => purpose.name == value);
                                  authControl.selectPropertyCategoryId(selectedPurpose.sId.toString());
                                  print(authControl.propertyCategoryId);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Amenity",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            Wrap(
                              spacing: 8.0, // Space between chips
                              runSpacing: 8.0, // Space between lines of chips
                              children: List.generate(
                                authControl.homeData!.propertyAmenities!.length,
                                    (index) {
                                  final val = authControl.homeData!.propertyAmenities![index];
                                  final isSelected = authControl.amenityIds.contains(val.sId.toString());
                                  return CustomSelectedButton(
                                    tap: () {
                                      authControl.setAmenityIds(val.sId.toString());
                                      print(authControl.amenityIds.join(','));
                                    },
                                    title: val.name.toString(),
                                    isSelected: isSelected,
                                  );
                                },
                              ),
                            ),

                            sizedBoxDefault(),
                            Text(
                              "Property State",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select State';
                                }
                                return null;
                              },
                              hintText: 'Select State',
                              items: locationControl.stateList!
                                  .map((purpose) => purpose.name)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = locationControl.stateList!
                                      .firstWhere((purpose) => purpose.name == value);
                                  locationControl.setStateId(
                                      selectedPurpose.id.toString()
                                  );
                                  Get.find<LocationController>().getCityList(locationControl.stateId);
                                  print(locationControl.stateId);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property City",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select City';
                                }
                                return null;
                              },
                              hintText: 'Select City',
                              items: locationControl.cityList!
                                  .map((purpose) => purpose.name)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = locationControl.cityList!
                                      .firstWhere((purpose) => purpose.name == value);
                                  locationControl.setCityId(selectedPurpose.id.toString());
                                  print(locationControl.cityId);

                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Locality",
                              style: senRegular.copyWith(
                                  fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select Locality';
                                }
                                return null;
                              },
                              hintText: 'Select Locality',
                              items: locationControl.localityList!
                                  .map((purpose) => purpose.name)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = locationControl.localityList!
                                      .firstWhere((purpose) => purpose.name == value);
                                  locationControl.setLocalityId( selectedPurpose.id.toString());
                                  print(locationControl.localityId);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Near By Location",
                              style: senRegular.copyWith(
                                  fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select Locality';
                                }
                                return null;
                              },
                              hintText: 'Select Locality',
                              items: authControl.homeData!.nearbyLocations!
                                  .map((purpose) => purpose.name!)
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  var selectedPurpose = authControl.homeData!.nearbyLocations!
                                      .firstWhere((purpose) => purpose.name == value);
                                  controller.setNearByLocationId(selectedPurpose.sId!);
                                  print(controller.nearByLocationId);
                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Direction",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomDropdown<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select Direction';
                                }
                                return null;
                              },
                              hintText: 'Select Direction',
                              items: controller.directionList,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectDirection(value);
                                  print(controller.selectedDirection);

                                }
                              },
                            ),
                            sizedBoxDefault(),
                            Text(
                              "Property Address",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            CustomTextField(
                              onTap: () {
                                Get.to(() => const VendorMapView());
                              },
                              controller: _addressController,
                              maxLines: 4,
                              readOnly: true,
                              hintText: "Add Property Address ",
                              capitalization: TextCapitalization.words,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Add Property Address';
                                }
                                return null;
                              },),
                            sizedBoxDefault(),
                            Text(
                              "Media Content",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize15),
                            ),
                            sizedBox10(),
                            Text("Display Image *",style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).disabledColor.withOpacity(0.40)),),
                            sizedBox10(),
                            InkWell(
                              onTap: () =>propertyController.pickDisplayImage(isRemove: false),
                              child: Container(
                                width: Get.size.width,
                                height: 150,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Theme.of(context).primaryColor),
                                    borderRadius: BorderRadius.circular(Dimensions.radius10)
                                ),
                                // padding: EdgeInsets.all(Dimensions.paddingSize20),
                                child: propertyController.pickedDisplayImage != null ?
                                Image.file(
                                  File(propertyController.pickedDisplayImage!.path), fit: BoxFit.cover,
                                ) :

                                Column(mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(Images.placeholder,height: 50,color: Theme.of(context).disabledColor.withOpacity(0.40),),
                                    sizedBox4(),
                                    Text("Add Main Image of Property",style: senMedium.copyWith(
                                        fontSize: Dimensions.fontSize12,
                                        color: Theme.of(context).disabledColor.withOpacity(0.40)),)
                                  ],
                                ),
                              ),
                            ),
                            sizedBox10(),
                            propertyController.pickedDisplayImage != null ? const SizedBox() :
                            Text('Add Property Display Image',style: senRegular.copyWith(color: Colors.redAccent,fontSize:Dimensions.fontSize12)),
                            sizedBox10(),
                            Text("Gallery Image *",style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).disabledColor.withOpacity(0.40)),),
                            sizedBox10(),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => propertyController.pickGalleryImage(),
                                  child: Container(
                                    width: Get.size.width,
                                    height: 200,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: propertyController.pickedGalleryImages.isNotEmpty
                                        ? GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                      ),
                                      itemCount: propertyController.pickedGalleryImages.length,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.file(
                                              File(propertyController.pickedGalleryImages[index].path),
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                                onPressed: () {
                                                  propertyController.removeImage(index);
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                        : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add_a_photo, size: 50, color: Theme.of(context).disabledColor.withOpacity(0.40)),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "Add Gallery Images Of Property",

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            sizedBox10(),
                            propertyController.pickedGalleryImages.isNotEmpty ? const SizedBox() :
                            Text('Add Property Gallery Images',style: senRegular.copyWith(color: Colors.redAccent,fontSize:Dimensions.fontSize12)),
                            sizedBoxDefault(),

                            propertyController.isLoading ?
                            const Center(child: CircularProgressIndicator()) :
                            CustomButtonWidget(
                              buttonText: '+ Add Property',
                              onPressed: () {
                                print('PropertyId: ${authControl.propertyTypeID}');
                                print('PurposeId: ${authControl.propertyPurposeID}');
                                print('CategoryId: ${authControl.propertyCategoryId}');
                                print('AmenityId: ${authControl.amenityId}');
                                print('Slug: for-sale-in-the-world-towers-lower-parel');
                                print('Title: ${_titleController.text}');
                                print('Description: ${_descController.text}');
                                print('MetaTitle: ${_metaTitleController.text}');
                                print('MetaDesc: ${_metaDescController.text}');
                                print('Address: ${_addressController.text}');
                                print('Unit: ${controller.unitDigit}');
                                print('VideoLink: ${_videoLinkController.text}');
                                print('Room: ${controller.roomDigit}');
                                print('Space: ${controller.spaceDigit}');
                                print('Bedroom: ${controller.bedroomDigit}');
                                print('Bathroom: ${controller.bathroomDigit}');
                                print('Floor: ${controller.floorDigit}');
                                print('Kitchen: ${controller.kitchenDigit}');
                                print('BuildYear: ${controller.buildYearController.text}');
                                print('Area: ${_areaController.text}');
                                print('Direction: ${controller.selectedDirection}');
                                print('Price: ${_priceController.text}');
                                print('MarketPrice: ${_marketPriceController.text}');
                                print('IsFeatured: true');
                                print('TopProperty: false');
                                print('ExpiryDate: ${controller.expireYearController.text}');
                                print('StateId: ${locationControl.stateId}');
                                print('CityId: ${locationControl.cityId}');
                                print('LocalityId: ${locationControl.localityId}');
                                print('Latitude: ${vendorMapController.latitude.toString()}');
                                print('Longitude: ${vendorMapController.longitude.toString()}');
                                print('DisplayImage: ${propertyController.pickedDisplayImage}');
                                print('GalleryImages: ${propertyController.pickedGalleryImages}');

                                if(_formKey.currentState!.validate()) {
                                  if( propertyController.pickedGalleryImages.isNotEmpty && propertyController.pickedDisplayImage != null ) {
                                    return propertyController.postPropertyApi(
                                      typeId: authControl.propertyTypeID,
                                      purposeId: authControl.propertyPurposeID,
                                      categoryId: authControl.propertyCategoryId,
                                      amenityId:authControl.amenityIds.join(','),
                                      slug: _slugController.text,
                                      title: _titleController.text,
                                      description: _descController.text,
                                      metaTitle: _metaTitleController.text,
                                      metaDesc: _metaDescController.text,
                                      address: _addressController.text,
                                      unit: controller.unitDigit,
                                      videoLink: _videoLinkController.text,
                                      room: controller.roomDigit,
                                      space: controller.spaceDigit,
                                      bedroom: controller.bedroomDigit,
                                      bathroom: controller.bathroomDigit,
                                      floor: controller.floorDigit,
                                      kitchen: controller.kitchenDigit,
                                      buildYear: controller.buildYearController.text,
                                      area: _areaController.text,
                                      // direction: controller.selectedDirection,
                                      direction: 'east',
                                      price: _priceController.text,
                                      marketPrice: _marketPriceController.text,
                                      isFeatured: 'false',
                                      topProperty: 'false',
                                      expiryDate: controller.expireYearController.text,
                                      stateId: locationControl.stateId!,
                                      cityId: locationControl.cityId!,
                                      localityId: [],
                                      latitude: vendorMapController.latitude.toString(),
                                      longitude:  vendorMapController.longitude.toString(),
                                      displayImage: propertyController.pickedDisplayImage,
                                      galleryImages: propertyController.pickedGalleryImages,
                                    );


                                  }



                                }

                              },
                            ),
                            sizedBox50(),

                          ],
                        ),
                      ),
                    );
                  });








              });
            }),
          );
        });
      })




    );
  }
}

class YearPickerWidget extends StatelessWidget {
  final int startYear;
  final int endYear;
  final Function(int) onYearSelected;

  YearPickerWidget({
    required this.startYear,
    required this.endYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: DateTime.now().year - startYear,
              ),
              onSelectedItemChanged: (int index) {
                onYearSelected(startYear + index);
              },
              children: List<Widget>.generate(endYear - startYear + 1, (int index) {
                return Center(
                  child: Text('${startYear + index}'),
                );
              }),
            ),
          ),
          CupertinoButton(
            child: const Text('Confirm'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}





class MultiSelectDropdown<T> extends StatelessWidget {
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemAsString;
  final void Function(List<T>) onChanged;

  MultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.itemAsString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        border: OutlineInputBorder(),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Row(
            children: [
              Checkbox(
                value: selectedItems.contains(item),
                onChanged: (bool? selected) {
                  if (selected != null) {
                    final updatedSelection = List<T>.from(selectedItems);
                    if (selected) {
                      updatedSelection.add(item);
                    } else {
                      updatedSelection.remove(item);
                    }
                    onChanged(updatedSelection);
                  }
                },
              ),
              Text(itemAsString(item)),
            ],
          ),
        );
      }).toList(),
      onChanged: (_) {}, // Prevent the dropdown from closing on click
      value: null,
      isExpanded: true,
    );
  }
}

