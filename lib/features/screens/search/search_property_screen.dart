import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_search_field.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';


class SearchPropertyScreen extends StatelessWidget {
  final String searchText;
  final String purposeId;
  const SearchPropertyScreen({super.key, required this.searchText, required this.purposeId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getSearchPropertyList(
        page: '1',
        limit: '10',
        latitude: '',
        longitude: '',
        query: searchText,
        purposeId: purposeId,

      );

    });
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        },
        icon: const Icon(CupertinoIcons.back)),
        title:  SearchField(
          tap: () {
            Get.back();
          },
            child: const SizedBox()),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('X Clear Filters')),
              sizedBoxW30(),
              sizedBoxW30(),


              Expanded(
                child: CustomButtonWidget(
                  height: 40,
                  isBold: false,
                  buttonText: 'Add Filters',
                onPressed: () {
                  Get.bottomSheet(
                    const FilterBottomSheet(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PropertyController>(builder: (propertyControl) {
          final list = propertyControl.searchPropertyList;
          final isListEmpty = list == null || list.isEmpty;
          final isLoading = propertyControl.isPropertyLoading;
          return
             isListEmpty && !isLoading
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: Dimensions.paddingSize40),
                  child: Center(
                    child: EmptyDataWidget(
                      image: Images.icSearchPlaceHolder,
                      fontColor: Theme.of(context).disabledColor,
                      text: '',
                    ),
                  ),
                )
              : isLoading || isListEmpty
                  ? const ExploreScreenShimmer()
                  : ListView.separated(
                      padding: const EdgeInsets.all(
                        Dimensions.paddingSizeDefault),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        return RecommendedItemCard(
                          vertical: true,
                          image: list[i].displayImages[0].image,
                          title: list[i].title.toString(),
                          description: list[i].description.toString(),
                          price: '${list[i].price.toString()}',
                          propertyId: list[i].id.toString(),
                          ratingText: '4.5',
                          likeTap: () {},
                          markerPrice: list[i].marketPrice.toString(),
                        );
                      },
                      separatorBuilder: (BuildContext context,
                              int index) =>
                          const SizedBox(
                              height: Dimensions.paddingSizeDefault),
                    );
        })


      ),
    );
  }
}
