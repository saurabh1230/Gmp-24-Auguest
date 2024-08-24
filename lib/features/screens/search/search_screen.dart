import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/explore_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/controller/searchController.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/screens/search/search_property_screen.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/styles.dart';

class SearchScreen extends StatelessWidget {
  final bool? isBackButton;

  SearchScreen({super.key, this.isBackButton = true});

  final List<String> staticCommunityList = [
    'Apartments',
    'Plots',
    'Houses',
    'Flats',
  ];

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getRecentSearchList();
    });
    return SafeArea(
      child: GetBuilder<AuthController>(builder: (authControl) {
        return  Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDecoratedContainer(
                    horizontal: Dimensions.paddingSize20,
                    child: Wrap(
                      spacing: 8.0, // Space between chips
                      runSpacing: 8.0, // Space between lines of chips
                      children: List.generate(
                        authControl.homeData!.propertyPurposes!.length,
                            (index) {
                          final val = authControl.homeData!.propertyPurposes![index];
                          return InkWell(
                            onTap: () {
                              final newValue = authControl.propertyPurposeID == val.sId.toString() ? '' : val.sId.toString();
                              authControl.selectPropertyPurposeId(newValue);
                              print(authControl.propertyPurposeID);
                            },
                            child: Container(
                              height: 40,
                              width: 80, // Adjust width to fit text
                              decoration: BoxDecoration(
                                color: authControl.propertyPurposeID == val.sId.toString()
                                    ? Theme.of(context).cardColor
                                    : Colors.transparent,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Center(
                                child: Text(
                                  val.name.toString(),
                                  style: senBold.copyWith(
                                    color: authControl.propertyPurposeID == val.sId.toString()
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          body: GetBuilder<PropertyController>(builder: (propertyControl) {
            final list = propertyControl.searchPropertyList;
            final isListEmpty = list == null || list.isEmpty;
            final isLoading = propertyControl.isPropertyLoading;
            final recentSearchList = propertyControl.recentSearchList;
            final recentSearchListEmpty =
                recentSearchList == null || recentSearchList.isEmpty;
            return
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (val) {
                          if (val.isEmpty) {
                            propertyControl.clearSearchPropertyList();
                          } else {

                          }
                        },
                        onSubmitted: (val) {
                          Get.to( SearchPropertyScreen(searchText: _searchController.text, purposeId: authControl.propertyPurposeID,));
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'City | Locality | Landmark',
                          hintStyle: TextStyle(
                            color: Theme.of(context).disabledColor.withOpacity(0.4),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal:  Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.location_fill,size: Dimensions.fontSize20,
                              color:Theme.of(context).disabledColor.withOpacity(0.4),),
                            Text('Use My Current Location',style: senRegular.copyWith(
                                color: Theme.of(context).disabledColor.withOpacity(0.4),
                                fontSize: Dimensions.fontSizeDefault
                            ),),
                          ],
                        ),
                        const Icon(CupertinoIcons.right_chevron,size: Dimensions.fontSize20 ,)
                      ],
                    ),
                  ),
                  const Divider(),
                  Wrap(
                    spacing: 4.0, // Adjust spacing as needed
                    children: propertyControl.recentSearchList!.map((val) {
                      return ChoiceChip(
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.white,
                        label: Text(
                          val.value.toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.80),
                          ),
                        ),
                        selected: false,
                        // Adjust according to your logic
                        onSelected: (selected) {
                          // Handle selection logic if needed
                        },
                      );
                    }).toList(),
                  ),
                  // isListEmpty && !isLoading && recentSearchListEmpty
                  //     ? Padding(
                  //         padding:
                  //             const EdgeInsets.only(top: Dimensions.paddingSize40),
                  //         child: Center(
                  //           child: EmptyDataWidget(
                  //             image: Images.icSearchPlaceHolder,
                  //             fontColor: Theme.of(context).disabledColor,
                  //             text: '',
                  //           ),
                  //         ),
                  //       )
                  //     : Expanded(
                  //         child: isLoading || isListEmpty
                  //             ? const ExploreScreenShimmer()
                  //             : ListView.separated(
                  //                 padding: const EdgeInsets.symmetric(
                  //                     horizontal: Dimensions.paddingSizeDefault),
                  //                 physics: const BouncingScrollPhysics(),
                  //                 shrinkWrap: true,
                  //                 itemCount: list.length,
                  //                 itemBuilder: (_, i) {
                  //                   return RecommendedItemCard(
                  //                     vertical: true,
                  //                     image: list[i].displayImage!.image.toString(),
                  //                     title: list[i].title.toString(),
                  //                     description: list[i].description.toString(),
                  //                     price: '${list[i].price.toString()}',
                  //                     propertyId: list[i].sId.toString(),
                  //                     ratingText: '4.5',
                  //                     likeTap: () {},
                  //                     markerPrice: list[i].marketPrice.toString(),
                  //                   );
                  //                 },
                  //                 separatorBuilder: (BuildContext context,
                  //                         int index) =>
                  //                     const SizedBox(
                  //                         height: Dimensions.paddingSizeDefault),
                  //               ),
                  //       ),
                ],
              );
          }),
        );

      })




    );
  }
}
