import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_shimmer_holders.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class RecomendedSection extends StatelessWidget {
  const RecomendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getPropertyList(page: '1');
    });
    return GetBuilder<PropertyController>(builder: (propertyControl) {
      final list = propertyControl.propertyList;
      final isListEmpty = list == null || list.isEmpty;
      final isLoading = propertyControl.isPropertyLoading;
      return Column(
        children: [
          isListEmpty && !isLoading
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSize100),
                  child: Center(
                      child: EmptyDataWidget(
                    image: Images.emptyDataImage,
                    fontColor: Theme.of(context).disabledColor,
                    text: 'No Recommended Properties yet',
                  )),
                )
              : isLoading
                  ? const RecommendedSectionShimmer(title: 'Recommended For You"',)
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                        top: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSizeDefault,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recommended For You",
                            style: senBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          sizedBox12(),
                          SizedBox(
                            height: Get.size.height * 0.30,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: list!.length > 6 ? 6 : list.length,
                              itemBuilder: (_, i) {
                                return RecommendedItemCard(
                                  image: list[i].displayImages[0].image,
                                  title: list[i].title.toString(),
                                  description: list[i].description.toString(),
                                  price: '${list[i].price.toString()}',
                                  propertyId: list[i].id.toString(),
                                  ratingText: '',
                                  likeTap: () {  }, markerPrice: list[i].marketPrice.toString(),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: Dimensions.paddingSizeDefault,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
        ],
      );
    });
  }
}

class RecommendedSectionShimmer extends StatelessWidget {
  final String title;
  final bool? vertical;
  const RecommendedSectionShimmer({super.key, required this.title,  this.vertical});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.paddingSizeDefault,
            top: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  sizedBox12(),
                ],
              ),
              SizedBox(
                height: Get.size.height * 0.28,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, i) {
                    return SizedBox(
                      width: 220, // Ensure the container is wide enough to test alignment
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryCardContainer(
                            color: Colors.black.withOpacity(0.1),
                            width: 220,
                            height: 126,
                            onTap: () {},
                            child: const SizedBox(),
                          ),
                          sizedBox8(),
                          const CustomShimmerTextHolder(
                            width: 220,
                            horizontalPadding: 0,
                          ),
                          sizedBox5(),
                          const CustomShimmerTextHolder(
                            width: 40,
                            horizontalPadding: 0,
                          ),
                          sizedBox8(),
                          Row(mainAxisAlignment: MainAxisAlignment.end, // Aligns the container to the right
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSize10),
                                ),
                                padding: const EdgeInsets.all(Dimensions.paddingSize5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min, // Ensures the Row is only as wide as its content
                                  children: [
                                    Text(
                                      "Check Out",
                                      style: senRegular.copyWith(
                                        fontSize: Dimensions.fontSize14,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: Dimensions.fontSize20,
                                      color: Colors.black.withOpacity(0.1),
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
                  separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );



  }
}
