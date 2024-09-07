import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/home/widgets/browse_more_section.dart';
import 'package:get_my_properties/features/screens/home/widgets/by_area_section.dart';
import 'package:get_my_properties/features/screens/home/widgets/home_screen_shimmer.dart';
import 'package:get_my_properties/features/screens/home/widgets/newly_constructed.dart';
import 'package:get_my_properties/features/screens/home/widgets/popular_in_location_section.dart';
import 'package:get_my_properties/features/screens/home/widgets/recomended_section.dart';
import 'package:get_my_properties/features/screens/home/widgets/services_section.dart';
import 'package:get_my_properties/features/screens/home/widgets/suitable_property_section.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/sign_up_details_dialog.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController filter = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().profileDetailsApi();
      Get.find<AuthController>().getHomeDataApi();
      // Get.find<PropertyController>().getPropertyList(page: '1',typeId: '66b097b38e94ad0e435526f4');
      // Get.find<PropertyController>().getTopPopularPropertyList(page: '1',);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: GetBuilder<AuthController>(builder: (authControl) {
        // if (authControl.profileData != null &&
        //     (authControl.profileData!.email == null || authControl.profileData!.email!.isEmpty) &&
        //     (authControl.profileData!.name == null || authControl.profileData!.name!.isEmpty)) {
        //   Future.delayed(Duration.zero, () {
        //     Get.dialog(
        //        SignUpDetailsDialog(),
        //       barrierDismissible: false,
        //     );
        //   });
        // }
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: 190.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.homeAppBarBg),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        sizedBox65(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                GestureDetector(behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Image.asset(
                                    Images.drawerMenuIcon,
                                    height: Dimensions.paddingSize30,
                                    width: Dimensions.paddingSize30,
                                  ),
                                ),
                                sizedBoxW7(),
                                Image.asset(
                                  Images.logo,
                                  height: Dimensions.paddingSize20,
                                  width: Dimensions.paddingSize20,
                                ),
                                sizedBoxW7(),
                                Text(
                                  "GetMyProperties",
                                  style: senBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSize18),
                                ),
                              ],
                            ),
                            CustomNotificationButton(tap: () {
                              Get.toNamed(RouteHelper.getNotificationRoute());
                            },color: Theme.of(context).cardColor,)
                          ],
                        ),
                        sizedBox10(),
                        InkWell(onTap: () {
                          Get.toNamed(RouteHelper.getLocationPickerRoute(isAddress: true));
                        },
                          child: Row(children: [
                             Icon(Icons.location_on_sharp,color : Theme.of(context).cardColor),
                             Expanded(child: Text(authControl.getSaveAddress().toString(),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize14,
                                  color: Theme.of(context).cardColor),)),
                          ],),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    InkWell(onTap: () {
                      Get.toNamed(RouteHelper.getSearchRoute());
                    },
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSize5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                          BorderRadius.circular(Dimensions.paddingSize5),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)
                          ],
                        ),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "  Search Property  ",
                                    style: senRegular.copyWith(
                                        fontSize: Dimensions.fontSize13,
                                        color: Theme.of(context)
                                            .hintColor), // Different color for "resend"
                                  ),
                                  // TextSpan(
                                  //   text: "Property",
                                  //   style: senRegular.copyWith(
                                  //       fontSize: Dimensions.fontSize12,
                                  //       color: Theme.of(context)
                                  //           .disabledColor
                                  //           .withOpacity(0.40)), // Default text color
                                  // ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.search,
                              color: Theme.of(context).hintColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:
              Column(
                children: [
                  const SuitablePropertySection(),
                  const RecomendedSection(),
                  const PopularInLocationSectionSection(),
                  // const ServicesSection(),
                  const NewlyConstructedSection(),
                  const ByAreaSection(),
                  BrowseMoreSection(
                    title: 'Buy A Property',
                    description:
                    'Discover your location with the most listings, including exclusive items, and an immersive photo experience.',
                    image: Images.buyAHousePlaceHolderImage,
                    onTap: () {
                      Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,title: 'Buy A Property',
                      propertyTypeId: '',
                      purposeId: '66b097808e94ad0e435526e6',direction: ''));
                    },
                  ),
                  BrowseMoreSection(
                    title: 'Rent A Property',
                    description:
                    'Creating a seamless online rental process: browse top listings, apply, and pay rent easily for a hassle-free experience.',
                    image: Images.rentAHousePlaceHolderImage,
                    onTap: () {
                      Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,title: 'Rent A Property',
                          propertyTypeId:'',
                          purposeId: '66b097878e94ad0e435526ea',direction: ''));
                    },
                  ),
                ],
              ),
            )
          ],
        );
      })
    );
  }
}


