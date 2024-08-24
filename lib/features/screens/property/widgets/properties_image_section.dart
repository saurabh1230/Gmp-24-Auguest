import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/data/models/response/property_detail_model.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';

class PropertiesImageSection extends StatelessWidget {
  final List<AllImages> galleryImages;
  final Function() onTap;
  final Color color;

  const PropertiesImageSection({
    super.key,
    required this.galleryImages,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Map AllImages instances to their URLs
    final fullImageUrls = galleryImages.map((image) => '${AppConstants.imgBaseUrl}${image.image}').toList();

    print('========> check all images $fullImageUrls');

    return GetBuilder<PropertyController>(builder: (controller) {
      return Stack(
        children: [
          if (fullImageUrls.isNotEmpty)
            fullImageUrls.length == 1
                ? CustomNetworkImageWidget(
              image: fullImageUrls[0],
              height: 250,
              radius: 0,
            )
                : FanCarouselImageSlider.sliderType2(
              indicatorActiveColor: Theme.of(context).primaryColor,
              imagesLink: fullImageUrls,
              isAssets: false,
              autoPlay: false,
              sliderHeight: 300,
              currentItemShadow: const [],
              sliderDuration: const Duration(milliseconds: 200),
              imageRadius: Dimensions.radius20,
              slideViewportFraction: 1.2,
            )
          else
            const CustomNetworkImageWidget(
              radius: Dimensions.radius5,
              image: '', // Display a placeholder if no images are available
            ),
          Positioned(
            top: Dimensions.paddingSize40,
            right: Dimensions.paddingSizeDefault,
            child: CustomNotificationButton(
              color: color,
              tap: onTap,
              icon: CupertinoIcons.heart_fill,
            ),
          ),
        ],
      );
    });
  }
}
