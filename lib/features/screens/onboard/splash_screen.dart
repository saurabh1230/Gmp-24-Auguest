import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/features/screens/Maps/location_view.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get/get.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _route();
    super.initState();



  }

  void _route() {
    final AuthController authController = Get.find<AuthController>();
    Timer(const Duration(seconds: 1), () async {
      if (authController.isLoggedIn()) {
        if (authController.isVendorLoggedIn()) {
          Get.offNamed(RouteHelper.getAdminDashboardRoute());
        } else if (authController.isCustomerLoggedIn()) {
          final String? savedAddress =  authController.getSaveAddress();
          if (savedAddress != null && savedAddress.isNotEmpty) {
            Get.offNamed(RouteHelper.getDashboardRoute());
          } else {
            Get.toNamed(RouteHelper.getLocationPickerRoute());
          }
        }
      } else {
        Get.offNamed(RouteHelper.getSignUpRoute());
      }
    });
  }

  // void _route() {
  //   final AuthController authController = Get.find<AuthController>();
  //   Timer(const Duration(seconds: 1), () async {
  //     // if (Get.find<AuthController>().isLoggedIn()) {
  //     //   Get.offNamed(RouteHelper.getDashboardRoute());
  //     // } else {
  //     //   Get.offNamed(RouteHelper.getSignUpRoute());
  //     // }
  //     if (authController.isLoggedIn()) {
  //       if (authController.isVendorLoggedIn()) {
  //         Get.offNamed(RouteHelper.getAdminDashboardRoute()); // Vendor dashboard route
  //       } else {
  //         Get.toNamed(RouteHelper.getLocationPickerRoute());
  //         // Get.offNamed(RouteHelper.getDashboardRoute()); // Customer dashboard route
  //       }
  //     } else {
  //       Get.offNamed(RouteHelper.getSignUpRoute()); // Sign up route
  //     }
  //
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          decoration:  const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff3b9bfe), Color(0xff235e95)],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            image: DecorationImage(image: AssetImage(Images.splashScreenBG),fit: BoxFit.cover)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSize75),
              child: Image.asset(Images.logoWithText),
            ),
          ),
        ),
    );


  }
}
