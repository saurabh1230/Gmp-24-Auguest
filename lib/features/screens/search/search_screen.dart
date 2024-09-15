import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/controller/searchController.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:get_my_properties/features/screens/search/search_property_screen.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatelessWidget {
  final bool? isBackButton;

  SearchScreen({super.key, this.isBackButton = true});

  final List<String> staticCommunityList = [
    'Apartments',
    'Plots',
    'Houses',
    'Flats',
  ];
  final _controller = TextEditingController();
  final _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getRecentSearchList();
    });
    return GetBuilder<AuthController>(builder: (authControl) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          drawer: const CustomDrawer(),
          appBar: CustomAppBar(
            title: 'Search',
            isBackButtonExist: isBackButton!,
          ),
          bottomNavigationBar: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSize40),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.find<PropertyController>().getPropertyList(
                          page: '1',
                        );
                      },
                      child: const Text('X Clear Filters')),
                  sizedBoxW30(),
                  sizedBoxW30(),
                  Expanded(
                    child: CustomButtonWidget(
                      height: 40,
                      isBold: false,
                      buttonText: 'Add Filters',
                      onPressed: () {
                        Get.bottomSheet(
                          const FilterBottomSheet(
                            searchNavigation: true,
                          ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          body: GetBuilder<PropertySearchController>(builder: (searchControl) {
            return GetBuilder<PropertyController>(builder: (propertyControl) {
              final list = propertyControl.propertyList;
              final isListEmpty = list == null || list.isEmpty;
              final isLoading = propertyControl.isPropertyLoading;
              final recentSearchList = propertyControl.recentSearchList;
              final homedat = authControl.homeData == null;
              final recentSearchListEmpty = recentSearchList == null || recentSearchList.isEmpty;
              return Column(
                children: [
                  sizedBox10(),
                  // homedat
                  //     ? Center(child: CircularProgressIndicator())
                  //     : Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: Dimensions.paddingSizeDefault),
                  //         child: Row(
                  //           children: [
                  //             Wrap(
                  //               spacing: 8.0, // Space between chips
                  //               runSpacing: 8.0, // Space between lines of chips
                  //               children: List.generate(
                  //                 authControl
                  //                     .homeData!.propertyPurposes!.length,
                  //                 (index) {
                  //                   final val = authControl
                  //                       .homeData!.propertyPurposes![index];
                  //                   return InkWell(
                  //                     onTap: () {
                  //                       final newValue =
                  //                           authControl.propertyPurposeID ==
                  //                                   val.sId.toString()
                  //                               ? ''
                  //                               : val.sId.toString();
                  //                       authControl
                  //                           .selectPropertyPurposeId(newValue);
                  //                       print(authControl.propertyPurposeID);
                  //                     },
                  //                     child: Container(
                  //                       height: 40,
                  //                       width: 80,
                  //                       decoration: BoxDecoration(
                  //                         color: authControl
                  //                                     .propertyPurposeID ==
                  //                                 val.sId.toString()
                  //                             ? Theme.of(context).primaryColor
                  //                             : Theme.of(context).cardColor,
                  //                         border: Border.all(
                  //                           width: 0.5,
                  //                           color:
                  //                               Theme.of(context).primaryColor,
                  //                         ),
                  //                         shape: BoxShape.rectangle,
                  //                         borderRadius: BorderRadius.circular(
                  //                             Dimensions.radius20),
                  //                       ),
                  //                       child: Center(
                  //                         child: Text(
                  //                           val.name.toString().contains('Sale')
                  //                               ? 'Buy'
                  //                               : 'Rent',
                  //                           style: senBold.copyWith(
                  //                             color: authControl
                  //                                         .propertyPurposeID ==
                  //                                     val.sId.toString()
                  //                                 ? Theme.of(context).cardColor
                  //                                 : Theme.of(context)
                  //                                     .primaryColor,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TypeAheadField<String>(
                      suggestionsCallback: (pattern) async {
                        if (pattern.isEmpty) {
                          return [];
                        }
                        await searchControl.fetchSuggestions(pattern);
                        return searchControl.suggestions;
                      },
                      itemBuilder: (context, String suggestion) {
                        return Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSize12),
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.arrow_up_right,
                                size: Dimensions.fontSizeDefault,
                                color: Theme.of(context).disabledColor.withOpacity(0.60),
                              ),
                              sizedBoxW5(),
                              Expanded(
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: '',
                                    style: DefaultTextStyle.of(context).style.copyWith(color: Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: suggestion,
                                        style: senRegular.copyWith(
                                          color: Theme.of(context).disabledColor,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _controller.text = suggestion;
                        Get.to(() => SearchPropertyScreen(
                          searchText: _controller.text.trim(),
                          purposeId: '',
                        ));
                      },
                      noItemsFoundBuilder: (context) => const SizedBox.shrink(), // Hides the no items found message
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _controller,
                        onSubmitted: (val) {
                          Get.to(SearchPropertyScreen(
                            searchText: _controller.text.trim(),
                            purposeId: '',
                          ));
                        },
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).cardColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(width: 0.5),
                          ),
                          hintText: 'Search for localities or cities',
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding:
                  //       const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  //   child: Container(
                  //     height: 45,
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).cardColor,
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.1),
                  //           spreadRadius: 1,
                  //           blurRadius: 5,
                  //         ),
                  //       ],
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Flexible(
                  //           child: TextField(
                  //             onChanged: (val) {
                  //               if (val.isEmpty) {
                  //                 propertyControl.clearSearchPropertyList();
                  //               } else {}
                  //             },
                  //             onSubmitted: (val) {
                  //               Get.to(SearchPropertyScreen(
                  //                 searchText: _searchController.text.trim(),
                  //                 purposeId: authControl.propertyPurposeID,
                  //               ));
                  //             },
                  //             controller: _searchController,
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: 'Search Property',
                  //               hintStyle: TextStyle(
                  //                 color: Theme.of(context).hintColor,
                  //               ),
                  //             ),
                  //             style: TextStyle(
                  //               fontSize: 14.0,
                  //               color: Theme.of(context).hintColor,
                  //             ),
                  //           ),
                  //         ),
                  //         GestureDetector(
                  //           behavior: HitTestBehavior.translucent,
                  //           onTap: () {
                  //             Get.to(() => SearchPropertyScreen(
                  //                   searchText: _searchController.text.trim(),
                  //                   purposeId: authControl.propertyPurposeID,
                  //                 ));
                  //           },
                  //           child: Icon(
                  //             Icons.search,
                  //             color: Theme.of(context).hintColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  /*   const Divider(),
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
                ),*/
                  const Divider(),
                  recentSearchListEmpty
                      ? const SizedBox()
                      : Expanded(
                        child: ListView(
                            children: [
                              const Text('Recent Searches',textAlign: TextAlign.center,),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSize10),
                                    child: Wrap(
                                      spacing: 6.0, // Adjust spacing as needed
                                      children: propertyControl.recentSearchList!
                                          .map((val) {
                                        return ChoiceChip(
                                          selectedColor:
                                              Theme.of(context).primaryColor,
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                            width: 0.7, // Border width
                                          ),
                                          label: Text(
                                            val.value.toString(),
                                            style: senRegular.copyWith(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: Dimensions.fontSize12),
                                          ),
                                          selected: false,
                                          // Adjust according to your logic
                                          onSelected: (selected) {
                                            print(val.value.toString());
                                            _searchController.text =
                                                val.value.toString();
                                            Get.to(() => SearchPropertyScreen(
                                                  searchText: val.value.toString(),
                                                  purposeId:
                                                      authControl.propertyPurposeID,
                                                ));
                                            // Handle selection logic if needed
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ),
                ],
              );
            });
          }));
    });
  }
}
