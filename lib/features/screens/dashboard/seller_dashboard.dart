import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/nav_bar_item.dart';
import 'package:get_my_properties/features/screens/inquiry/all_user_inquiry.dart';
import 'package:get_my_properties/features/screens/profile/profile_screen.dart';
import 'package:get_my_properties/features/screens/saved/saved_screen.dart';
import 'package:get_my_properties/features/screens/seller_screens/home/seller_home.dart';
import 'package:get_my_properties/features/screens/seller_screens/paylog/paylog_screen.dart';
import 'package:get_my_properties/features/screens/seller_screens/property/post_property_screen.dart';
import 'package:get_my_properties/features/screens/seller_screens/seller_properties_screen.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';

class SellerDashboardScreen extends StatefulWidget {
  final int pageIndex;
  const SellerDashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  SellerDashboardScreenState createState() => SellerDashboardScreenState();
}

class SellerDashboardScreenState extends State<SellerDashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().getVendorDataApi();
      Get.find<AuthController>().getHomeDataApi();
    });
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
       SellerHome(),
       SellerPropertiesScreen(),
       PostPropertyScreen(),
       const AllUserInquiry(),
       // const PaylogScreen(),
       ProfileScreen(),
    ];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _setPage(0);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        floatingActionButton: !GetPlatform.isMobile ? null : FloatingActionButton(
          elevation: 5,
          backgroundColor: _pageIndex == 2 ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
          onPressed: () => _setPage(2),
          child: Icon(
            Icons.add, size: Dimensions.paddingSize34,
            color: _pageIndex == 2 ? Theme.of(context).cardColor : Theme.of(context).disabledColor.withOpacity(0.30),
          ),
        ),
        floatingActionButtonLocation: !GetPlatform.isMobile ? null : FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: !GetPlatform.isMobile ? const SizedBox() : BottomAppBar(
          elevation: 5,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(0/*Dimensions.paddingSize20*/),
            child: Row(children: [
              BottomNavItem(img: Images.icSellerDashboardIcon, isSelected: _pageIndex == 0, tap: () => _setPage(0), title: 'Home',),
              BottomNavItem(img: Images.navBarExplore, isSelected: _pageIndex == 1, tap: () => _setPage(1), title: 'Properties',),
              const Expanded(child: SizedBox()),
              BottomNavItem(img: Images.icInquiry, isSelected: _pageIndex == 3, tap: () => _setPage(3), title: 'Inquiries',),
              BottomNavItem(img:Images.navBarProfile, isSelected: _pageIndex == 4, tap: () {
                _setPage(4);
              }, title: 'Profile',),
            ]),
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
