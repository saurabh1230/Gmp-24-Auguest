import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/data/models/response/property_model.dart';
import 'package:get_my_properties/features/screens/dashboard/seller_dashboard.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/property/prperties_details_screen.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_confirmation_dialog.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/theme/price_converter.dart';

class RecommendedItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final String markerPrice;
  final String propertyId;
  final bool? vertical;
  final String? ratingText;
  final bool? isLikeButton;
  final Function()? likeTap;
  final bool? isVendor;
  final Color? bookmarkIconColor;
  final PropertyModel? propertyModel;
  final Function()? vendorDeleteTap;

  const RecommendedItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.vertical = false,
    required this.propertyId,
    this.ratingText,
    this.likeTap,
    this.isLikeButton = true, this.isVendor = false, this.bookmarkIconColor, this.propertyModel, required this.markerPrice, this.vendorDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if(isVendor!) {
              print('isVendor');
              vendorDeleteTap!();

            } else {
              Get.toNamed(
                RouteHelper.getPropertiesDetailsScreen(
                  title,
                  propertyId,
                ),
              );

            }

          },
          child: Container(
            width: vertical! ? Get.size.width : 240,
            padding: EdgeInsets.only(
              right: vertical! ? 0 : Dimensions.paddingSizeDefault,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: vertical! ? 200 : 126,
                  width: vertical! ? Get.size.width : 220,
                  child: CustomNetworkImageWidget(
                    radius: Dimensions.radius5,
                    image: '${AppConstants.imgBaseUrl}$image',
                      // placeholder:Images.emptyDataImage
                  ),
                ),
                sizedBox8(),
                Text(
                  title,
                  style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: senRegular.copyWith(
                    fontSize: Dimensions.fontSize14,
                    color: Theme.of(context).disabledColor.withOpacity(0.50),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                sizedBox8(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                       child: Text(
                       '₹ ${IndianPriceFormatter.formatIndianPrice(double.parse(price))} - ${IndianPriceFormatter.formatIndianPrice(double.parse(markerPrice))}',
                        // price,
                        style: senBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    isVendor! ?
                        const SizedBox() :
                    CheckoutArrowButton(
                      tap: () {

                        Get.toNamed(
                          RouteHelper.getPropertiesDetailsScreen(
                            title,
                            propertyId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (vertical == true)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSize10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (ratingText != null) // Check if ratingText is not null

                    isVendor! ?
                    CustomDecoratedContainer(
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            vendorDeleteTap!();
                          }, icon: Icon(Icons.delete,color: Theme.of(context).cardColor,))
                          // IconButton(onPressed: () {
                          //   Get.to(SellerDashboardScreen(pageIndex: 2));
                          // }, icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,))
                          // Text(
                          //   ratingText!,
                          //   style: senRegular.copyWith(
                          //     fontSize: Dimensions.fontSize12,
                          //     color: Theme.of(context).hintColor,
                          //   ),
                          // ),
                          // Icon(
                          //   Icons.star,
                          //   color: Theme.of(context).hintColor,
                          //   size: Dimensions.fontSize15,
                          // ),
                        ],
                      ),
                    ): const SizedBox(),
                    // const SizedBox(),
                    // CustomDecoratedContainer(
                    //   child: Row(
                    //     children: [
                    //       IconButton(onPressed: () {
                    //         vendorDeleteTap!();
                    //       }, icon: Icon(Icons.delete,color: Theme.of(context).cardColor,))
                    //       // IconButton(onPressed: () {
                    //       //   Get.to(SellerDashboardScreen(pageIndex: 2));
                    //       // }, icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,))
                    //       // Text(
                    //       //   ratingText!,
                    //       //   style: senRegular.copyWith(
                    //       //     fontSize: Dimensions.fontSize12,
                    //       //     color: Theme.of(context).hintColor,
                    //       //   ),
                    //       // ),
                    //       // Icon(
                    //       //   Icons.star,
                    //       //   color: Theme.of(context).hintColor,
                    //       //   size: Dimensions.fontSize15,
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                  if (isLikeButton == true && likeTap != null) // Check if isLikeButton is true and likeTap is not null
                    CustomNotificationButton(
                      color: bookmarkIconColor,
                      // color: Theme.of(context).disabledColor.withOpacity(0.15),
                      tap: likeTap!,
                      icon: CupertinoIcons.heart_fill,
                    ),
                ],
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
