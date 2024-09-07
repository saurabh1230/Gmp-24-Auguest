import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class ByAreaSection extends StatelessWidget {
  const ByAreaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "By Area",
            style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
          sizedBox12(),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInkWell(
                      context,
                      tap: () {
                        Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                            propertyTypeId: '',
                            title: 'North Kolkata',
                            purposeId: '',
                          direction: 'north'
                        ));
                        // Add action for North Kolkata
                      },
                      title: 'North Kolkata',
                      img: Images.imgNorth,
                    ),
                    sizedBox10(),
                    buildInkWell(
                      context,
                      tap: () {
                        Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                            propertyTypeId: '',
                            title: 'South Kolkata',
                            purposeId: '',
                            direction: 'south'
                        ));
                      },
                      title: 'South Kolkata',
                      img: Images.imgSouth,
                    ),
                  ],
                ),
              ),
              sizedBoxW10(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInkWell(
                      context,
                      tap: () {
                        Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                            propertyTypeId: '',
                            title: 'East Kolkata',
                            purposeId: '',
                            direction: 'east'
                        ));
                      },
                      title: 'East Kolkata',
                      img: Images.imgEast,
                    ),
                    sizedBox10(),
                    buildInkWell(
                      context,
                      tap: () {
                        Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                            propertyTypeId: '',
                            title: 'West Kolkata',
                            purposeId: '',
                            direction: 'wast'
                        ));
                      },
                      title: 'West Kolkata',
                      img: Images.imgWest,
                    ),
                  ],
                ),
              ),
            ],
          ),
          sizedBox10(),
          buildInkWell(
            context,
            tap: () {
              Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                  propertyTypeId: '',
                  title: 'Center Kolkata',
                  purposeId: '',
                  direction: 'center'
              ));
            },
            title: 'Center Kolkata',
            img: Images.imgCenter,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  InkWell buildInkWell(
      BuildContext context, {
        required Function() tap,
        required String title,
        required String img,
        bool isFullWidth = false,
      }) {
    return InkWell(
      onTap: tap,
      child: Stack(
        children: [
          Image.asset(
            img,
            width: isFullWidth ? Get.size.width : null,
          ),
          Positioned(
            bottom: Dimensions.paddingSizeDefault,
            left: Dimensions.paddingSizeDefault,
            child: Text(
              title,
              style: senRegular.copyWith(
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
