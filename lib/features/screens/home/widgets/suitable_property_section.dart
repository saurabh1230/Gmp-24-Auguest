import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/home_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/features/widgets/custom_shimmer_holders.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class SuitablePropertySection extends StatelessWidget {
  const SuitablePropertySection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GetBuilder<AuthController>(builder: (authControl) {
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Center(
            child: authControl.homeData == null ||
                authControl.homeData!.propertyTypes == null ||
                authControl.homeData!.propertyTypes!.isEmpty ?
            const SuitablePropertyShimmer() :
            Column(
              children: [
                sizedBox12(),
                Text("Welcome to GetMyProperties",style: senRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                sizedBox4(),
                Text("We will help you find your suitable property",style: senRegular.copyWith(fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).disabledColor.withOpacity(0.40)),),
                sizedBox30(),
                SizedBox(
                  height: Get.size.height * 0.12,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: authControl.homeData!.propertyTypes!.length,
                    itemBuilder: (_,i) {
                      return PrimaryCardContainer(width: 160,
                        onTap: () {
                        Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                           propertyTypeId: authControl.homeData!.propertyTypes![i].sId.toString(),
                          title: authControl.homeData!.propertyTypes![i].name.toString(),
                          purposeId: '',direction: ''
                        ));
                          // Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                          //     "Sale",
                          //     authControl.homeData!.propertyTypes![i].name.toString(),
                          //     authControl.homeData!.propertyTypes![i].sId.toString(),
                          //     '66b097808e94ad0e435526e6'
                          //   // authControl.homeData!.propertyPurposes![i].sId.toString(),
                          // ));
                        },
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomNetworkImageWidget(image:  '${AppConstants.imgBaseUrl}${authControl.homeData!.propertyTypes![i].image}',
                                height: 50,width: 50,),
                            sizedBox4(),
                            Text(authControl.homeData!.propertyTypes![i].name.toString(),style: senRegular.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).primaryColor),),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: Dimensions.paddingSizeDefault,),),
                )
              ],
            ),

          ),
        );

      } );

    } );
  }
}

class SuitablePropertyShimmer extends StatelessWidget {
  const SuitablePropertyShimmer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizedBox12(),
          const CustomShimmerTextHolder(),
          sizedBox5(),
          const CustomShimmerTextHolder(horizontalPadding: Dimensions.paddingSize40),
          sizedBox20(),
          Center(
            child: SizedBox(
              height: Get.size.height * 0.10,
              child: ListView.separated(
                // padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_,i) {
                  return PrimaryCardContainer(
                      color: Colors.black.withOpacity(0.1),
                      width: 100,
                      onTap: () {
                      },
                      child: const SizedBox()
                  );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: Dimensions.paddingSizeDefault,),),
            ),
          )

        ],
      ),
    );
  }
}
