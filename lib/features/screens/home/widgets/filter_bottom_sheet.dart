import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/explore_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/search/search_property_screen.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_dropdown_button.dart';
import 'package:get_my_properties/features/widgets/filter_data_field.dart';
import 'package:get_my_properties/features/widgets/group_radio_buttons.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/theme/price_converter.dart';

class FilterBottomSheet extends StatelessWidget {
  final bool? searchNavigation;
  const FilterBottomSheet({super.key, this.searchNavigation = false, });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getHomeDataApi();
    });

    return Container(
      height: Get.size.height * 0.80,
      decoration:  BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radius10),
        topRight: Radius.circular(Dimensions.radius10),

      )),

      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return  Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSize10),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "${Get.find<PropertyController>().propertyList!.length.toString()} Results",
                        style: senBold.copyWith(fontSize: Dimensions.fontSize18),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: GetBuilder<ExploreController>(builder: (controller) {
                  return GetBuilder<AuthController>(builder: (authControl) {
                    return authControl.homeData == null
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.paddingSizeDefault),
                          child: authControl.homeData == null
                              ? const Center(
                              child: CircularProgressIndicator())
                              : Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Property For",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
                              ),
                              sizedBox10(),
                              Wrap(
                                spacing: 8.0, // Space between chips
                                runSpacing: 8.0, // Space between lines of chips
                                children: List.generate(
                                  authControl.homeData!.propertyPurposes!.length,
                                      (index) {
                                    final val = authControl.homeData!.propertyPurposes![index];
                                    final isSelected = authControl.propertyPurposeID == val.sId.toString();
                                    return CustomSelectedButton(
                                      tap: () {
                                        // Toggle the selection based on whether it is currently selected
                                        final newValue = isSelected ? '' : val.sId.toString();
                                        authControl.selectPropertyPurposeId(newValue);
                                        print(authControl.propertyPurposeID);
                                      },
                                      title: val.name.toString().contains("Sale") ? "Buy" : val.name.toString(),
                                      isSelected: isSelected, // Highlight if selected
                                    );
                                  },
                                ),
                              ),



                              sizedBox20(),
                              Text(
                                "Property Type",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
                              ),
                              sizedBox10(),
                              Wrap(
                                spacing: 8.0, // Space between chips
                                runSpacing: 8.0, // Space between lines of chips
                                children: List.generate(
                                  authControl.homeData!.propertyTypes!.length,
                                      (index) {
                                    final propertyType = authControl.homeData!.propertyTypes![index];
                                    final isSelected = authControl.propertyTypeIDs.contains(propertyType.sId.toString());
                                    return CustomSelectedButton(
                                      tap: () {
                                        authControl.selectPropertyTypeIds(propertyType.sId.toString());
                                        print(authControl.propertyTypeIDs.join(','));
                                      },
                                      title: propertyType.name.toString(),
                                      isSelected: isSelected,
                                    );
                                  },
                                ),
                              ),

                              sizedBox20(),

                              Text(
                                "Space",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
                              ),
                              sizedBox10(),
                              Wrap(
                                spacing: 8.0, // Space between chips
                                runSpacing: 8.0, // Space between lines of chips
                                children: List.generate(
                                  controller.spaceType.length,
                                      (index) {
                                    final spaceType = controller.spaceType[index];
                                    final isSelected = controller.spaceTypeIDs.contains(spaceType);
                                    return InkWell(
                                      onTap: () {
                                        controller.selectSpaceTypeIDs(spaceType);
                                        print(controller.spaceTypeIDs.join(','));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                                          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.10) : Colors.transparent,
                                          border: Border.all(
                                            width: 0.5,
                                            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${spaceType} bhk',
                                            style: senRegular.copyWith(
                                              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              sizedBox20(),
                              Text(
                                "Bathrooms",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
                              ),
                              sizedBox10(),
                              Wrap(
                                spacing: 8.0, // Space between chips
                                runSpacing: 8.0, // Space between lines of chips
                                children: List.generate(
                                  controller.bathroomType.length,
                                      (index) {
                                    final val = controller.bathroomType[index];
                                    final isSelected = controller.bathroomIDs.contains(val);
                                    return InkWell(
                                      onTap: () {
                                        controller.selectBathroomTypeIDs(val);
                                        print(controller.bathroomIDs.join(','));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.10) : Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 0.5,
                                            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            val,
                                            style: senRegular.copyWith(
                                              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              sizedBox20(),
                              Text(
                                "Other Options",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
                              ),
                              sizedBox10(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Min Value: ₹ ${controller.startPriceValue.value.round().toString()}',
                                        style: senRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Max Value: ₹ ${IndianPriceFormatter.formatIndianPrice(double.parse(controller.endPriceValue.value.round().toString()))}',
                                        style: senRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Obx(() => RangeSlider(
                                  min: 0.0, // Minimum value
                                  max: 100000000.0, // Maximum value (1 crore)
                                  divisions: 100, // Number of divisions for finer granularity
                                  labels: RangeLabels(
                                    controller.formatCurrency(controller.startPriceValue.value),
                                    controller.formatCurrency(controller.endPriceValue.value),
                                  ),
                                  values: RangeValues(
                                    controller.startPriceValue.value,
                                    controller.endPriceValue.value,
                                  ),
                                  onChanged: (values) {
                                    controller.setPriceValue(values); // Update the values when slider changes
                                    print('Updated range values: ${values.start.round()} - ${values.end.round()}');
                                  },
                                )),
                              ),
                              Text(
                                "Properties Amenities",
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize15),
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
                              sizedBox20(),
                              sizedBox20(),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          Get.find<PropertyController>().getPropertyList(page: '1',

                                          );
                                          Get.back();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Clear All",
                                              style: senRegular.copyWith(
                                                  color: Theme.of(
                                                      context)
                                                      .primaryColor),
                                            ),
                                            Icon(
                                              Icons.clear,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    child: CustomButtonWidget(
                                      buttonText: "Apply",
                                      onPressed: () {
                                        print('propertyPurposeID: ${authControl.propertyPurposeID}');
                                        print('propertyTypeID: ${authControl.propertyTypeIDs.join(',')}');
                                        print('startPriceValue: ${controller.formatPrice(controller.startPriceValue.toDouble())}');
                                        print('endPriceValue: ${controller.formatPrice(controller.endPriceValue.toDouble())}');
                                        print('spaceTypeID: ${controller.spaceTypeIDs.join(',')}');
                                        print('stateId: ${controller.stateId}');
                                        print('bathroomID: ${controller.bathroomIDs.join(',')}');
                                        print('propertyCategoryIds: ${controller.propertyCategoryIds.join(', ')}');
                                        print('amenityId: ${authControl.amenityIds.join(',')}');
                                        Get.find<PropertyController>().getPropertyList(page: '1',
                                          stateId: '',
                                          cityId: '',
                                          purposeId: authControl.propertyPurposeID,
                                          typeId: authControl.propertyTypeIDs.join(','),
                                          minPrice: controller.formatPrice(controller.startPriceValue.toDouble()),
                                          maxPrice: controller.formatPrice(controller.endPriceValue.toDouble()),
                                          space: controller.spaceTypeIDs.join(','),
                                          bathroom: controller.bathroomIDs.join(','),
                                          // categoryId:  controller.propertyCategoryIds.join(', '),
                                          amenityId: authControl.amenityIds.join(','),
                                          // lat: Get.find<AuthController>().getLatitude().toString(),
                                          // long: Get.find<AuthController>().getLongitude().toString(),
                                        );

                                        if (searchNavigation == true) {
                                          Get.to(() => SearchPropertyScreen(searchText: '', purposeId: '',));


                                        } else {
                                          Get.back();

                                        }

                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                      ),
                    );
                  });
                }),
              ),
            ],
          );
        } ),



    );
  }
}



class CustomDialogCheckBox extends StatelessWidget {
  final List<String> itemList;
  final List<String> selectedItems;
  final ValueChanged<String> onItemSelected;
  final String dialogTitle;
  final Color selectedColor;
  final Color unselectedColor;

  const CustomDialogCheckBox({
    super.key,
    required this.itemList,
    required this.selectedItems,
    required this.onItemSelected,
    required this.dialogTitle,
    this.selectedColor = const Color(0xff4B164C),
    this.unselectedColor = const Color(0xff4B164C),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              dialogTitle,
              style: TextStyle(fontSize: 18, color: selectedColor),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                final item = itemList[index];
                final isSelected = selectedItems.contains(item);
                return CheckboxListTile(
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? selectedColor
                          : unselectedColor.withOpacity(0.80),
                    ),
                  ),
                  value: isSelected,
                  onChanged: (bool? selected) {
                    onItemSelected(item);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

