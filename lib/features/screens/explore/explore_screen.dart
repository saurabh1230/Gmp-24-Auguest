import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/Maps/search_location_map_view.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/explore/widgets/explore_card_widget.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:get_my_properties/features/screens/home/widgets/recomended_section.dart';
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


class ExploreScreen extends StatefulWidget {
  final bool? isBrowser;
  final String? title;
  final String? propertyTypeId;
  final String? purposeId;

  const ExploreScreen({super.key, this.isBrowser= false, this.title, this.propertyTypeId, this.purposeId});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
      Get.find<PropertyController>().getPropertyList(page: '1',
          purposeId: widget.purposeId,
          typeId:widget.propertyTypeId);
    });
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(
        isBackButtonExist: widget.isBrowser! ? true : false,
        title:widget.isBrowser! ? '${widget.title}' : "Explore",
        menuWidget: CustomNotificationButton(
          tap: () {
            Get.toNamed(RouteHelper.getNotificationRoute());
          },
        ),
      ),
      body: GetBuilder<PropertyController>(builder: (propertyControl) {
        final list = propertyControl.propertyList;
        final isListEmpty = list == null || list.isEmpty;
        final isLoading = propertyControl.isPropertyLoading;
        return


          Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  Expanded(child: CustomOutlineButton(title: 'Location',
                    tap: () {
                    Get.to(const SearchLocationScreen());
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
            sizedBox8(),
            isListEmpty && !isLoading
                ? Center(
                child: EmptyDataWidget(
                  image: Images.emptyDataImage,
                  fontColor: Theme.of(context).disabledColor,
                  text: 'No Properties yet',
                )) :
            Expanded(
              child: SingleChildScrollView(
                child: isLoading ||isListEmpty ? const ExploreScreenShimmer() :
                ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    return
                      RecommendedItemCard(
                      vertical: true,
                      image: list[i].displayImage!.image.toString(),
                      title:  list[i].title.toString(),
                      description:  list[i].description.toString(),
                      price: '₹ ${list[i].price.toString()}',
                      propertyId: list[i].sId.toString(),
                      ratingText: '4.5',likeTap:() {},
                    );
                    // return ExploreCardWidget(
                    //     itemCount: 10,
                    //     image:  list[i].displayImage!.image.toString(),
                    //     ratingText: "4.2",
                    //     imagesLength:  list[i].galleryImages!.length.toString(),
                    //     likeTap: () {},
                    //     detailsTap: () => Get.toNamed(RouteHelper.getPropertiesDetailsScreen("La Convent",'')),
                    //     propertyCategory:  list[i].category!.name.toString(),
                    //     title:  list[i].title.toString(),
                    //     description: list[i].description.toString(),
                    //     price: '₹ ${list[i].price.toString()}',
                    //     // pageController: _pageController
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimensions.paddingSizeDefault),
                ),
              ),
            ),
          ],
        );
      }),




    );
  }
}

class ExploreScreenShimmer extends StatelessWidget {
  const ExploreScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical:  Dimensions.paddingSizeDefault),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, i) {
        return  SizedBox(
          width: Get.size.width , // Ensure the container is wide enough to test alignment
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryCardContainer(
                color: Colors.black.withOpacity(0.1),
                width:  Get.size.width ,
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
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimensions.paddingSizeDefault),
    );
  }
}
