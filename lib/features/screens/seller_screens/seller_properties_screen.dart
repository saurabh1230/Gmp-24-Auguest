import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/controller/vendor_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class SellerPropertiesScreen extends StatelessWidget {
  SellerPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyController propertyControl = Get.find<PropertyController>();
    final VendorController vendorControl = Get.find<VendorController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      propertyControl.getVendorPropertyList(page: '1', status: 'active');
    });

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(
        title: "My Properties",
        isBackButtonExist: false,
      ),
      body: GetBuilder<PropertyController>(builder: (propertyControl) {
        final list = propertyControl.verdorPropertyList;
        final isLoading = propertyControl.isPropertyLoading;

        return Column(
          children: [
            sizedBoxDefault(),
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                scrollDirection: Axis.horizontal,
                itemCount: vendorControl.vendorPropertyStatus.length,
                itemBuilder: (_, i) {
                  final val = vendorControl.vendorPropertyStatus[i];
                  return CustomDecoratedContainer(
                    color: vendorControl.vendorPropertyStatusID == val
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                    onTap: () {
                      vendorControl.setVendorPropertyID(val);
                      propertyControl.getVendorPropertyList(
                          page: '1', status: vendorControl.vendorPropertyStatusID);
                      print(vendorControl.vendorPropertyStatusID);
                    },
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSize10,
                    radius: Dimensions.radius5,
                    child: Text(
                      val.toUpperCase(),
                      style: senRegular.copyWith(
                        fontSize: Dimensions.fontSize12,
                        color: vendorControl.vendorPropertyStatusID == val
                            ? Theme.of(context).cardColor
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => sizedBoxW10(),
              ),
            ),

            sizedBox10(),
            sizedBox8(),
            isLoading
                ? const Padding(
                  padding: EdgeInsets.only(top: Dimensions.paddingSize100),
                  child: Center(child: CircularProgressIndicator()),
                )
                : list == null || list.isEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
                  child: Center(child: EmptyDataWidget(
                  image: Images.emptyDataImage,
                  fontColor: Theme.of(context).disabledColor,
                  text: 'No ${vendorControl.vendorPropertyStatusID.toUpperCase()} Property yet',
                                ),
                              ),
                )
                : Expanded(
              child: SingleChildScrollView(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    return RecommendedItemCard(
                      vendorDeleteTap: () {
                        // print(vendorControl.vendorPropertyStatus[i]);
                        propertyControl.deleteVenderProperty(list[i].id,vendorControl.vendorPropertyStatus[i]);
                      },
                      isVendor: true,
                      vertical: true,
                      image: list[i].displayImage![0].image.toString(),
                      title: list[i].title ?? '',
                      description: list[i].description ?? '',
                      price: '${list[i].price ?? ''}',
                      propertyId: list[i].id ?? '',
                      ratingText: '4.5',
                      likeTap: () {},
                      isLikeButton: false, markerPrice:list[i].marketPrice.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
