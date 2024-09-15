import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/profile_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/screens/inquiry/all_user_inquiry.dart';
import 'package:get_my_properties/features/screens/seller_screens/property/post_property_screen.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_confirmation_dialog.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get_my_properties/utils/theme/light_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getHomeDataApi();
    });
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (authControl) {
          return authControl.homeData == null ||
                 authControl.profileData == null
                ? const Center(child: CircularProgressIndicator()) :
           SafeArea(
            child: Container(
              width: Get.size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize20,horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20),
                      ),
                    ),
                    child:
                    Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(onTap: () {
                              Get.back();
                            }, child: Icon(Icons.arrow_back,color: Theme.of(context).cardColor,)),
                            sizedBoxW10(),
                            Text("Welcome",style: senRegular.copyWith(fontSize: Dimensions.fontSize18, color: Theme.of(context).cardColor),),
                            // const Spacer(),
                            // CustomNotificationButton(
                            //   icon: Icons.person,
                            //   tap: () {
                            //     CustomNotificationButton(
                            //       tap: () {
                            //
                            //
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                        // Get.find<AuthController>().profileData!.userType == 'customer' ?
                        // authControl.isCustomerLoggedIn() ? const SizedBox() :
                        // Padding(
                        //   padding: const EdgeInsets.only(top: Dimensions.paddingSize10),
                        //   child: CustomButtonWidget(color: Theme.of(context).cardColor,
                        //       isBold: false,
                        //       fontSize: Dimensions.fontSize15,
                        //       buttonText: "Register",onPressed: () {},
                        //       textColor: Theme.of(context).primaryColor),
                        // )
                      ],
                    ),
                  ),
                      sizedBox10(),
      
                  authControl.isCustomerLoggedIn() ? const SizedBox() :
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        InkWell(onTap: () {  Get.toNamed(RouteHelper.getPostPropertyRoute());},
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Post Property",style: senRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).disabledColor),),
                                IconButton(onPressed: () {
                                  // Get.to(() => PostPropertyScreen(isBackButton: true,));
                                  // Get.to(PostPropertyScreen(isBackButton: true,));
                                  Get.toNamed(RouteHelper.getPostPropertyRoute());
                                },
                                  icon: const Icon(Icons.add),
                                  color: Theme.of(context).primaryColor,)
                              ],
                            ),
                          ),
                        ),
                        buildContainer(context,"Edit Profile", tap: () {
                          Get.toNamed(RouteHelper.getProfileRoute(isBackButton: true));
                          // Get.to(const AllUserInquiry(isBackButtonExist: true,));
                        }),
                        buildContainer(context,"Inquiry Request", tap: () {
                          Get.to(const AllUserInquiry(isBackButtonExist: true,));
                        }),
      
                      ],
                    ),
                  ),
                  // sizedBoxDefault(),
      
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            authControl.isCustomerLoggedIn() ?
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Looking For",style: senBold.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.30)),),
                                ListView.builder(
                                    itemCount: authControl.homeData!.propertyTypes!.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_,i) {
                                  return buildContainer(context,authControl.homeData!.propertyTypes![i].name.toString(),tap : () {
                                    Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                                        propertyTypeId: authControl.homeData!.propertyTypes![i].sId.toString(),
                                        title: authControl.homeData!.propertyTypes![i].name.toString(),
                                        purposeId: '',
                                        direction: ''
                                    ));
                                    // Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                                    //     "Sale",
                                    //     authControl.homeData!.propertyTypes![i].name.toString(),
                                    //     authControl.homeData!.propertyTypes![i].sId.toString(),
                                    //     '66b097808e94ad0e435526e6'
                                    //   // authControl.homeData!.propertyPurposes![i].sId.toString(),
                                    // ));
                                  });
                                }),
      
                                // buildContainer(context,"Apartment",tap : () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("Sale", "Apartment",''));
                                // }),
                                // buildContainer(context,"House", tap: () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("Sale", "House",''));
                                // }),
                                // buildContainer(context,"Land/ Plot", tap: () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("Sale", "Land/ Plot",''));
                                // }),
                                // sizedBoxDefault(),
                                // Text("Property For Rent",style: senBold.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.30)),),
                                // ListView.builder(
                                //     itemCount: authControl.homeData!.propertyTypes!.length,
                                //     shrinkWrap: true,
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     itemBuilder: (_,i) {
                                //       return
                                //         buildContainer(context,authControl.homeData!.propertyTypes![i].name.toString(),tap : () {
                                //           Get.toNamed(RouteHelper.getExploreRoute(isBrowser: true,
                                //               propertyTypeId: authControl.homeData!.propertyTypes![i].sId.toString(),
                                //               title: authControl.homeData!.propertyTypes![i].name.toString(),
                                //               purposeId: '66b097878e94ad0e435526ea'
                                //           ));
                                //           // Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                                //           //   "Rent",
                                //           //   authControl.homeData!.propertyTypes![i].name.toString(),
                                //           //   authControl.homeData!.propertyTypes![i].sId.toString(),
                                //           // '66b097878e94ad0e435526ea'));
                                //         });
                                //     }),
                                // buildContainer(context,"Apartment", tap: () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("Rent", "Apartment",''));
                                // }),
                                // buildContainer(context,"House", tap: () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("Rent", "House",''));
                                // }),
                                // buildContainer(context,"Land/ Plot", tap: () {
                                //   Get.toNamed(RouteHelper.getSellAndRentDashboardRoute("rent", "Land/ Plot",''));
                                // }),
                            /*    sizedBoxDefault(),
                                Text("Explore",style: senBold.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.30)),),
                                buildContainer(context,"Near Locality", tap: () {
                                  Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                                      "Sale",
                                      "Near Locality",
                                      "66b097c68e94ad0e435526fc",
                                      '66b097878e94ad0e435526ea'
                                  ));
                                }),
                                buildContainer(context,"Newly Constructed", tap: () {
                                  Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                                      "Sale",
                                      "Near Locality",
                                      "66b097c68e94ad0e435526fc",
                                      '66b097878e94ad0e435526ea'
                                  ));
                                }),
                                buildContainer(context,"Featured Properties", tap: () {
                                  Get.toNamed(RouteHelper.getSellAndRentDashboardRoute(
                                      "Sale",
                                      "Near Locality",
                                      "66b097c68e94ad0e435526fc",
                                      '66b097878e94ad0e435526ea'
                                  ));
                                }),*/
                                sizedBoxDefault(),
                                Text("My Account",style: senBold.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.30)),),
                                buildContainer(context,"My Enquiry", tap: () {
                                  Get.to(const AllUserInquiry(isBackButtonExist: true,));
                                }),
                                buildContainer(context,"Recent Searches", tap: () {
                                  Get.toNamed(RouteHelper.getSearchRoute());
                                }),
                                buildContainer(context,"Saved Properties", tap: () {
                                  Get.toNamed(RouteHelper.getSavedRoute(isBackButton: true,));
                                }),
                                buildContainer(context,"Edit Profile", tap: () {
                                  Get.toNamed(RouteHelper.getProfileRoute(isBackButton: true));
                                }),
                                // buildContainer(context,"History", tap: () {
                                //   Get.toNamed(RouteHelper.getSearchRoute());
                                // }),
                                sizedBoxDefault(),
                                Text("Other Options",style: senBold.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.30)),),
                                // buildContainer(context,"Home Inspection", tap: () {
                                //   showCustomSnackBar('Currently in the development');
                                // }),
                                // buildContainer(context,"Rent Agreement", tap: () {
                                //   showCustomSnackBar('Currently in the development');
                                // }),
                                // buildContainer(context,"Tenant Verification", tap: () {
                                //   showCustomSnackBar('Currently in the development');
                                // }),
                                // buildContainer(context,"Property Valuation", tap: () {
                                //   showCustomSnackBar('Currently in the development');
                                // }),
                                // buildContainer(context,"Recent Searches", tap: () {
                                //   Get.toNamed(RouteHelper.getSearchRoute());
                                //
                                // }),
                                // buildContainer(context,"Rating & Reviews", tap: () {Get.toNamed(RouteHelper.getRatingsAndReviewRoute());}),
                                buildContainer(context,"Terms & Conditions", tap: () {
                                  showCustomSnackBar('Currently in the development');
                                }),
                                buildContainer(context,"Help Center", tap: () {
                                  showCustomSnackBar('Currently in the development');
                                }),
                              ],
                            ): const SizedBox(),
                            buildContainer(color:redColor.withOpacity(0.08),
                                context,"Logout", tap: () {
                                  Get.dialog(ConfirmationDialog(icon: Images.icLogout, description: 'Are you Sure to Logout', onYesPressed: () {Get.toNamed(RouteHelper.getSignUpRoute());},));
                                }),
                            // Row(
                            //   children: [
                            //     TextButton(
                            //         onPressed: () {
                            //       Get.dialog(ConfirmationDialog(icon: Images.icLogout, description: 'Are you Sure to Logout', onYesPressed: () {Get.toNamed(RouteHelper.getSignUpRoute());},));
                            //
                            //     }, child: Text('Logout',
                            //     style: senSemiBold.copyWith(fontSize: Dimensions.fontSize18,
                            //     color: redColor),)),
                            //   ],
                            // ),
                            sizedBoxDefault(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  //   child: CustomButtonWidget(
                  //     isBold: false,
                  //     buttonText: "Logout",fontSize: Dimensions.fontSize14,
                  //     onPressed: () {
                  //       Get.dialog(ConfirmationDialog(icon: Images.icLogout, description: 'Are you Sure to Logout', onYesPressed: () {Get.toNamed(RouteHelper.getSignUpRoute());},));
                  //     },),
                  // ),
                  sizedBox30()
                ],
              ),
            ),
          );
        })
      ),
    );
  }

  InkWell buildContainer(
      BuildContext context,
      String title, {
        Color? color,
        required Function() tap,
      }) {
    return InkWell(
      onTap: tap,
      child: Container(
        width: Get.size.width,
        margin: const EdgeInsets.only(top: Dimensions.paddingSize10),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeDefault,
          horizontal: Dimensions.paddingSize10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius5),
          color: color ?? Theme.of(context).primaryColor.withOpacity(0.04),
        ),
        child: Text(
          title,
          style: senRegular.copyWith(
            fontSize: Dimensions.fontSize13,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
    );
  }

}
