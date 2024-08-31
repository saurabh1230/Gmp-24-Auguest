import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/features/widgets/custom_shimmer_holders.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/theme/price_converter.dart';

class NewlyConstructedSection extends StatelessWidget {
  const NewlyConstructedSection({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getPropertyList(page: '1');
    });
    return Padding(
      padding: const EdgeInsets.only(left:Dimensions.paddingSizeDefault,top:Dimensions.paddingSizeDefault,
        bottom:Dimensions.paddingSizeDefault,),
      child:

      GetBuilder<PropertyController>(builder: (propertyControl) {
        final list = propertyControl.featuredPropertyList;
        final isListEmpty = list == null || list.isEmpty ;
        final isLoading = propertyControl.isPropertyLoading;
        return  isListEmpty && !isLoading
            ? Center(
                child: EmptyDataWidget(
                  image: Images.emptyDataImage,
                  fontColor: Theme.of(context).disabledColor,
                  text: 'No Popular Properties yet',
                )) : isLoading ?
        const NewlyConstructedSectionShimmer() :
          Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Featured Properties",style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
            sizedBox12(),
            SizedBox(
              height: Get.size.height * 0.40,
              child: ListView.separated(
                padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                scrollDirection: Axis.horizontal,
                itemCount: list!.length > 6 ? 6 : list.length,
                itemBuilder: (_,i) {
                  return InkWell(
                    onTap: () => Get.toNamed(
                        RouteHelper.getPropertiesDetailsScreen(
                            list[i].title.toString(),
                            list[i].id)),
                    child: SizedBox(
                      width: 307,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 307,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomNetworkImageWidget(
                                            height: 222,
                                            radius: Dimensions.radius5,
                                            image: '${AppConstants.imgBaseUrl}${list[i].displayImages[0].image}'),
                                        sizedBox10(),
                                        Text(list[i].title.toString(),
                                          style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,),
                                        Text(list[i].description.toString(),
                                          style: senRegular.copyWith(
                                            fontSize: Dimensions.fontSize14,
                                            color: Theme.of(context).disabledColor.withOpacity(0.70),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,),
                                        sizedBox5(),
                                        Text("₹ ${IndianPriceFormatter.formatIndianPrice(double.parse(list[i].price.toString()))} - ${IndianPriceFormatter.formatIndianPrice(double.parse(list[i].marketPrice.toString()))} | ${list[i].bedroom.toString()} BHK Apartment",
                                          style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).primaryColor),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: Dimensions.paddingSizeDefault,),),
            )
          ],);
      }),
    );
  }
}

class NewlyConstructedSectionShimmer extends StatelessWidget {
  const NewlyConstructedSectionShimmer({super.key, });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Newly Constructed",style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
        sizedBox12(),
        SizedBox(
          height: Get.size.height * 0.40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (_,i) {
              return SizedBox(
                width: 307,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            PrimaryCardContainer(
                              color: Colors.black.withOpacity(0.1),
                              width: 307,
                              height: 222,
                              onTap: () {},
                              child: const SizedBox(),
                            ),
                            sizedBox10(),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomShimmerTextHolder(width: 140,horizontalPadding: 0,),
                                sizedBox10(),
                                const CustomShimmerTextHolder(width: 80,horizontalPadding: 0,),
                                sizedBox10(),
                                const CustomShimmerTextHolder(width: 80,horizontalPadding: 0,),
                              ],),
                            // Container(
                            //   height: Dimensions.paddingSize40,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: Dimensions.paddingSizeDefault,),),
        )
      ],);



  }
}