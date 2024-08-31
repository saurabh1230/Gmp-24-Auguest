import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/bookmark_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/explore/widgets/explore_card_widget.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';


class SavedScreen extends StatefulWidget {
  final bool? isBackButton;
  final String? title;
  const SavedScreen({super.key,  this.isBackButton = false, this.title});

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(Get.find<AuthController>().isVendorLoggedIn()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<PropertyController>().getVendorPropertyList(page: '1', status: 'active');
        });
      } else {
        Get.find<BookmarkController>().getBookmarkedPropertyList(page: '1',);
      }
      Get.find<BookmarkController>().getBookmarkedPropertyList(page: '1',);

    });
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        isBackButtonExist: widget.isBackButton! ? true : false,
        title: widget.isBackButton! ? widget.title ?? "Saved" : "Saved",
        menuWidget: CustomNotificationButton(
          tap: () {
            Get.toNamed(RouteHelper.getNotificationRoute());
          },
        ),
      ),
      body: GetBuilder<BookmarkController>(builder: (bookmarkControl) {
      final list = bookmarkControl.bookmarkedPropertyList;
      final isListEmpty = list == null || list.isEmpty;
      final isLoading = bookmarkControl.isLoading;
      return   isListEmpty && !isLoading
          ? Center(
          child: EmptyDataWidget(
            image: Images.icSearchPlaceHolder,
            fontColor: Theme.of(context).disabledColor,
            text: 'No Saved yet',
          )) : Column(
        children: [
          sizedBox8(),
          Expanded(
            child: isLoading ||isListEmpty ? const ExploreScreenShimmer() : SingleChildScrollView(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (_, i) {
                  return RecommendedItemCard(
                    vertical: true,

                    image: list[i].displayImages[0].image.toString(),
                    title:  list[i].title.toString(),
                    description:  list[i].description.toString(),
                    price: list[i].price.toString(),
                    propertyId: list[i].id.toString(),
                    ratingText: '4.5',
                    likeTap:() {
                      bookmarkControl.removeSavedBookMarkList(list[i].id);
                    },
                    bookmarkIconColor:  Theme.of(context).primaryColor, markerPrice: list[i].marketPrice.toString(),

                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimensions.paddingSizeDefault),
              ),
            ),
          ),
        ],
      );}),
    );
  }
}
