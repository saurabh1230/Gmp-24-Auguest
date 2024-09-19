

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/bookmark_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/Maps/properties_map.dart';
import 'package:get_my_properties/features/screens/Maps/properties_map.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_shimmer_holders.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

import '../../../controller/map_controller.dart';

class ExploreScreen extends StatefulWidget {
  final bool? isBrowser;
  final String? title;
  final String? propertyTypeId;
  final String? purposeId;  final String? direction;


  const ExploreScreen(
      {super.key,
      this.isBrowser = false,
      this.title,
      this.propertyTypeId,
      this.purposeId, this.direction});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}


class _ExploreScreenState extends State<ExploreScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.isBrowser == true) {
        Get.find<PropertyController>().getExplorePropertyList(
          page: '1',typeId:widget.propertyTypeId,
          purposeId: widget.purposeId,direction: widget.direction,
        );
        Get.find<PropertyController>().getPropertyList(page: '1',typeId:widget.propertyTypeId,
            purposeId: widget.purposeId,direction: widget.direction,
          // lat: Get.find<AuthController>().getLatitude().toString(),
          // long: Get.find<AuthController>().getLongitude().toString(),
        );
      } else {
        double? latitude = Get.find<AuthController>().getExploreLatitude();
        double? longitude = Get.find<AuthController>().getExploreLongitude();
        Get.find<PropertyController>().getExplorePropertyList(
          page: '1',
          lat: latitude != null ? latitude.toString() : '',
          long: longitude != null ? longitude.toString() : '',
        );
      }
      double? latitude = Get.find<AuthController>().getExploreLatitude();
      double? longitude = Get.find<AuthController>().getExploreLongitude();
      if (latitude == null || longitude == null) {
        Get.find<PropertyController>().getPropertyLatLngList(
          page: '1',
          distance: '10',
        );
      } else {
        Get.find<PropertyController>().getPropertyLatLngList(
          page: '1',
          lat: latitude.toString(),
          long: longitude.toString(),
        );
      }
      // Get.find<PropertyController>().getPropertyLatLngList(
      //   page: '1',
      //   distance: '10',
      // );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<PropertyController>().getPropertyList(
          page: '1',
          lat: Get.find<AuthController>().getLatitude().toString(),
          long: Get.find<AuthController>().getLongitude().toString(),
          direction: '',

        );
        Get.find<PropertyController>().getPropertyList(page: '1',);
        Get.find<PropertyController>().getTopPopularPropertyList(page: '1',
            lat: Get.find<AuthController>().getLatitude().toString(),
            long: Get.find<AuthController>().getLongitude().toString(),
            direction: ''


        );
        return true;
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar:  AppBar(
          title: Text( widget.isBrowser! ? '${widget.title}' : "Explore",
              style: senRegular.copyWith(fontSize: Dimensions.fontSize18, color: Theme.of(context).cardColor)),
          centerTitle: true,
          leading:  widget.isBrowser! ? IconButton(
            icon:  const Icon(Icons.arrow_back),
            color: Theme.of(context).cardColor,
            onPressed: () {
              Get.find<PropertyController>().getPropertyList(page: '1',
                  lat: Get.find<AuthController>().getLatitude().toString(),
                  long: Get.find<AuthController>().getLongitude().toString(),
                  direction: ''
              );
              Get.find<PropertyController>().getTopPopularPropertyList(page: '1',
                  lat: Get.find<AuthController>().getLatitude().toString(),
                  long: Get.find<AuthController>().getLongitude().toString(),
                  direction: ''
              );
              Get.back();
            },
          ) :  Builder(
            builder: (context) => InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Image.asset(Images.drawerMenuIcon,height: 24,width: 24,),
              ),
            ),),

          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
            child: CustomNotificationButton(
                tap: () {
                  Get.toNamed(RouteHelper.getNotificationRoute());
                },
              ),
          )
          ],
        ),
        // appBar: CustomAppBar(
        //   isBackButtonExist: widget.isBrowser! ? true : false,
        //   title: widget.isBrowser! ? '${widget.title}' : "Explore",
        //   menuWidget: CustomNotificationButton(
        //     tap: () {
        //       Get.toNamed(RouteHelper.getNotificationRoute());
        //     },
        //   ),
        // ),
        body: GetBuilder<PropertyController>(builder: (propertyControl) {
          final list = propertyControl.explorePropertyList;
          final isListEmpty = list == null || list.isEmpty;
          final isLoading = propertyControl.isPropertyLoading;
          return Column(
            children: [
              sizedBox8(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    Expanded(child: CustomOutlineButton(title: 'Location',
                      tap: () {
                        Get.to(() =>  PropertiesMapScreen(
                          purposeId: widget.purposeId!,
                          propertyTypeId:
                          widget.propertyTypeId != null ?
                          widget.propertyTypeId.toString() : '',
                        ));
                      },)),
                    sizedBoxW5(),
                    Expanded(child: CustomOutlineButton(
                      title: 'Filters',
                      filter: true,
                      filterText: "",
                      tap: () {
                        Get.bottomSheet(
                          const FilterBottomSheet(),
                          backgroundColor: Colors.transparent, isScrollControlled: true,
                        );
                      },)),
                    sizedBoxW5(),
                    Expanded(child: CustomButtonWidget(
                      height: 35,
                      radius: Dimensions.radius5,
                      isBold: false,
                      buttonText: "X Clear Filter",
                      onPressed: () {
                        Get.find<PropertyController>().getPropertyList(page: '1',
                        );
                      },
                      fontSize:  Dimensions.fontSize12,))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: RichText(textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${list!.length} ',
                        style: senSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).primaryColor),
                      ),
                      TextSpan(
                        text: 'Properties ',
                        style: senSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                            color: Theme.of(context).primaryColor),
                      ),
                      TextSpan(
                        text: Get.find<AuthController>().getExploreAddress() == null ||
                            Get.find<AuthController>().getExploreAddress().toString().isEmpty
                            ? 'Available For You'
                            : 'Available in ${Get.find<AuthController>().getExploreAddress().toString()}',
                        style: senRegular.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               sizedBox10(),

               Expanded(
                    child: isListEmpty && !isLoading
                        ? Center(
                      child: EmptyDataWidget(
                        image: Images.icSearchPlaceHolder,
                        fontColor: Theme.of(context).disabledColor,
                        text:
                        'No Property Found Near you',
                      ),
                    )
                        :
                    isLoading || isListEmpty
                        ? const ExploreScreenShimmer()
                        : SingleChildScrollView(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (_, i) {
                                print('price ${list[i].price.toString()}');
                                return GetBuilder<BookmarkController>(
                                  builder: (bookmarkControl) {
                                    bool isBookmarked = bookmarkControl
                                        .bookmarkIdList
                                        .contains(list[i].id);
                                    return RecommendedItemCard(
                                      vertical: true,
                                      image: list[i]
                                          .displayImages[0].image
                                          .toString(),
                                      title: list[i].title.toString(),
                                      description:
                                          list[i].description.toString(),
                                      price: ' ${list[i].price.toString()}',
                                      propertyId: list[i].id.toString(),
                                      ratingText: '4.5',
                                      likeTap: () {
                                        isBookmarked
                                            ? bookmarkControl
                                                .removeFromBookMarkList(
                                                    list[i].id)
                                            : bookmarkControl
                                                .addToBookmarkList(list[i]);
                                      },
                                      bookmarkIconColor: isBookmarked
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .cardColor
                                              .withOpacity(0.60),
                                      propertyModel: list[i],
                                      markerPrice: list[i].marketPrice.toString(),
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context,
                                      int index) =>
                                  const SizedBox(
                                      height: Dimensions.paddingSizeDefault),
                            ),
                          ),
                  ),
            ],
          );
        }),
      ),
    );
  }
}

class ExploreScreenShimmer extends StatelessWidget {
  const ExploreScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, i) {
        return SizedBox(
          width: Get.size.width,
          // Ensure the container is wide enough to test alignment
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryCardContainer(
                color: Colors.black.withOpacity(0.1),
                width: Get.size.width,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // Aligns the container to the right
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius:
                          BorderRadius.circular(Dimensions.paddingSize10),
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSize5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      // Ensures the Row is only as wide as its content
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
          const SizedBox(height: Dimensions.paddingSizeDefault),
    );
  }
}
