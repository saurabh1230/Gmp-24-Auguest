import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/bookmark_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get_my_properties/utils/theme/price_converter.dart';


class MapPropertySheet extends StatelessWidget {
  final String lat;
  final String long;
  final String? purposeId;
  final String? propertyTypeId;
  const MapPropertySheet({super.key, required this.lat, required this.long,  this.purposeId, this.propertyTypeId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get.find<PropertyController>().getPropertyList(page: '1',
      //     lat: lat,
      //     long:long,
      // purposeId: purposeId,
      // typeId: propertyTypeId);
    });

    return Container(
      height: Get.size.height * 0.50,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20)
        )
      ),
      child: GetBuilder<PropertyController>(builder: (propertyControl) {
        final list = propertyControl.propertyLatList;
        final isListEmpty = list == null || list.isEmpty;
        final isLoading = propertyControl.isPropertyLoading;
        return  Column(
          children: [
            sizedBox10(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${list!.length}',
                    style: senSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ' Property',
                    style: senSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).primaryColor),
                  ),
                  TextSpan(
                    text: ' Found Near You',
                    style: senRegular.copyWith(fontSize: Dimensions.fontSize14,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
            sizedBox5(),
            Expanded(
              child:  isListEmpty && !isLoading
                  ? Center(
                child:
                EmptyDataWidget(
                  image: Images.icSearchPlaceHolder,
                  fontColor: Theme.of(context).disabledColor,
                  text: 'No Properties Found',
                ),
              )
                  : isLoading || isListEmpty
                  ? Center(child: const CircularProgressIndicator())
                  :
              SingleChildScrollView(
                child: Column(
                  children: [
                    sizedBox8(),
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        print('price ${list[i].price.toString()}');
                        return GetBuilder<BookmarkController>(
                          builder: (bookmarkControl) {
                            bool isBookmarked = bookmarkControl
                                .bookmarkIdList
                                .contains(list[i].id);
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  RouteHelper.getPropertiesDetailsScreen(
                                    list[i].title,
                                    list[i].id,
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomNetworkImageWidget(
                                        height: 100,width: 100,
                                        radius: Dimensions.radius5,
                                        image: '${AppConstants.imgBaseUrl}${list[i].displayImages[0].image}',
                                        // placeholder:Images.emptyDataImage
                                      ),
                                      sizedBoxW10(),
                                      Flexible(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              list[i].title,
                                              style: senBold.copyWith(fontSize: Dimensions.fontSize14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            sizedBox10(),
                                            Text(
                                              list[i].description,
                                              style: senRegular.copyWith(
                                                fontSize: Dimensions.fontSize13,
                                                color: Theme.of(context).disabledColor.withOpacity(0.50),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            sizedBox10(),
                                            Text(
                                              '₹ ${IndianPriceFormatter.formatIndianPrice(double.parse(list[i].price.toString()))} - ${IndianPriceFormatter.formatIndianPrice(double.parse(list[i].marketPrice.toString()))}',
                                              // price,
                                              style: senBold.copyWith(
                                                fontSize: Dimensions.fontSizeDefault,
                                                color: Theme.of(context).hintColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),


                                ],
                              ),
                            );

                          },
                        );
                      },
                      separatorBuilder: (BuildContext context,
                          int index) =>
                      const SizedBox(
                          height: Dimensions.paddingSizeDefault),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      })


    );
  }
}
