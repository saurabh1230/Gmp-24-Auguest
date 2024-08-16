import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class RecommendedItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final String propertyId;
  final bool? vertical;
  final String? ratingText;
  final Function()? likeTap;

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
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(
              RouteHelper.getPropertiesDetailsScreen(
                title,
                propertyId,
              ),
            );
          },
          child: Container(
            width: vertical! ? Get.size.width : 220,
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
                        price,
                        style: senBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
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
        if (vertical == true && ratingText != null)  // Check for null and vertical
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSize10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDecoratedContainer(
                    child: Row(
                      children: [
                        Text(
                          ratingText!,
                          style: senRegular.copyWith(
                            fontSize: Dimensions.fontSize12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).hintColor,
                          size: Dimensions.fontSize15,
                        ),
                      ],
                    ),
                  ),
                  if (likeTap != null)  // Check if likeTap is not null
                    CustomNotificationButton(
                      color: Theme.of(context).disabledColor.withOpacity(0.15),
                      tap: likeTap!,
                      icon: CupertinoIcons.heart,
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
