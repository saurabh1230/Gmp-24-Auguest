import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/home_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/drawer.dart';
import 'package:get_my_properties/features/screens/dashboard/widgets/inquiry_request_section.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/inquiry/all_user_inquiry.dart';

import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_shimmer_holders.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/features/widgets/sign_up_details_dialog.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SellerHome extends StatefulWidget {
  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().isCustomerLoggedIn() ?
      Get.find<AuthController>().profileDetailsApi() :
      Get.find<AuthController>().profileDetailsApi(isVendor : true);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(title: "Dashboard", menuWidget: CustomNotificationButton(
        tap: () {},
      ),),
      body: GetBuilder<HomeController>(builder: (controller) {
        return GetBuilder<AuthController>(builder: (authControl) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   final name = authControl.profileData?.name;
          //   print(name);
          //   if ( name == null || name.isEmpty) {
          //     print('Profile data or name is null');
          //     Get.dialog(
          //       SignUpDetailsDialog(),
          //       barrierDismissible: false,
          //     );
          //   } else {
          //     print('Profile data exists with name: $name');
          //   }
          // });

          final data = authControl.vendorDashboardData;
          final list = data?.latestInquiries ?? [];
          final isLoading = authControl.isLoading;
          
          if (isLoading) {
            return const SellerHomeShimmer();
          }

          if (data == null || list.isEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 350,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: Dimensions.paddingSizeDefault, // Horizontal spacing between columns
                        mainAxisSpacing: Dimensions.paddingSizeDefault, // Vertical spacing between rows
                        childAspectRatio: 1.8, // Aspect ratio of each item
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.sellerDashboardCount.length,
                      itemBuilder: (_, i) {
              
                        return Container(
                          decoration: BoxDecoration(
                              color: controller.sellerDashboardColors[i],
                              borderRadius: BorderRadius.circular(Dimensions.radius10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0',
                                style: senBold.copyWith(
                                  fontSize: Dimensions.fontSize30,
                                  color: Theme.of(context).cardColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.sellerDashboardOverView[i],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: senRegular.copyWith(
                                  fontSize: Dimensions.fontSize12,
                                  color: Theme.of(context).cardColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Inquiry Request",
                              style: senRegular.copyWith(fontSize: Dimensions.fontSize14, color: Theme.of(context).disabledColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: SfCartesianChart(
                            // Initialize category axis
                              primaryXAxis: const CategoryAxis(),
                              series: <CartesianSeries>[
                                // Initialize line series
                                LineSeries<ChartData, String>(
                                    dataSource: [
                                      // Bind data source
                                      ChartData('Jan', 35),
                                      ChartData('Feb', 28),
                                      ChartData('Mar', 34),
                                      ChartData('Apr', 32),
                                      ChartData('May', 40)
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBox10(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Enquiry Requests",
                            style: senRegular.copyWith(
                              fontSize: Dimensions.fontSize14,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: senRegular.copyWith(
                                fontSize: Dimensions.fontSize14,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                          child: Text('No Inquiries Yet')
                          
                          // EmptyDataWidget(
                          //   image: Images.emptyDataImage,
                          //   fontColor: Theme.of(context).disabledColor,
                          //   text: 'No Inquiries yet',
                          // )
                      
                      ),
                    ],
                  )
              
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 350,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: Dimensions.paddingSizeDefault, // Horizontal spacing between columns
                      mainAxisSpacing: Dimensions.paddingSizeDefault, // Vertical spacing between rows
                      childAspectRatio: 1.8, // Aspect ratio of each item
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:  controller.sellerDashboardCount.length,
                    itemBuilder: (_, i) {
                      final dataCounts = [
                        data.totalProperty.toString(),
                        data.totalApproved.toString(),
                        data.totalPending.toString(),
                        data.totalFeatured.toString(),
                        data.totalDisabled.toString(),
                        data.totalRejected.toString(),
                      ];
                      return Container(
                        decoration: BoxDecoration(
                            color: controller.sellerDashboardColors[i],
                            borderRadius: BorderRadius.circular(Dimensions.radius10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              list.isEmpty ? "0" : dataCounts[i],
                              style: senBold.copyWith(
                                fontSize: Dimensions.fontSize30,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.sellerDashboardOverView[i],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: senRegular.copyWith(
                                fontSize: Dimensions.fontSize12,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Inquiry Request",
                            style: senRegular.copyWith(fontSize: Dimensions.fontSize14, color: Theme.of(context).disabledColor),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 200,
                      //   child: SfCartesianChart(
                      //     // Initialize category axis
                      //       primaryXAxis: const CategoryAxis(),
                      //       series: <CartesianSeries>[
                      //         // Initialize line series
                      //         LineSeries<ChartData, String>(
                      //             dataSource: [
                      //               // Bind data source
                      //               ChartData('Jan', 35),
                      //               ChartData('Feb', 28),
                      //               ChartData('Mar', 34),
                      //               ChartData('Apr', 32),
                      //               ChartData('May', 40)
                      //             ],
                      //             xValueMapper: (ChartData data, _) => data.x,
                      //             yValueMapper: (ChartData data, _) => data.y
                      //         )
                      //       ]
                      //   ),
                      // ),
                    ],
                  ),
                ),
                sizedBox10(),
                InquiryRequestSection(
                  inquiries: data.latestInquiries,
                  onSeeAll: () {
                    Get.to(const AllUserInquiry(isBackButtonExist: true,));
                  },
                ),
                sizedBox40(),
              ],
            ),
          );
        });

      }),

    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}


class SellerHomeShimmer extends StatelessWidget {
  const SellerHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 350,
            child: GridView.builder(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.paddingSizeDefault,
                mainAxisSpacing: Dimensions.paddingSizeDefault,
                childAspectRatio: 1.8,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (_, i) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.radius10)
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomShimmerTextHolder(horizontalPadding: Dimensions.paddingSize65,),
                      sizedBox10(),
                      const CustomShimmerTextHolder(horizontalPadding: Dimensions.paddingSize10,),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Inquiry Request",
                      style: senRegular.copyWith(fontSize: Dimensions.fontSize14, color: Theme.of(context).disabledColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      series: <CartesianSeries>[
                        LineSeries<ChartData, String>(
                            dataSource: [
                              ChartData('Jan', 35),
                              ChartData('Feb', 28),
                              ChartData('Mar', 34),
                              ChartData('Apr', 32),
                              ChartData('May', 40)
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
          sizedBox10(),
          const InquiryRequestShimmer(),
          sizedBox40(),
        ],
      ),
    );
  }
}
