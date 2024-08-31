import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/features/screens/dashboard/nav_bar_item.dart';

import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/home/home_screen.dart';
import 'package:get_my_properties/features/screens/profile/profile_screen.dart';
import 'package:get_my_properties/features/screens/saved/saved_screen.dart';
import 'package:get_my_properties/features/screens/search/search_screen.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  const DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  // Timer _timer;
  // int _orderCount;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().isCustomerLoggedIn() ?
      Get.find<AuthController>().profileDetailsApi() :
      Get.find<AuthController>().profileDetailsApi(isVendor : true);
      Get.find<AuthController>().getHomeDataApi();
    });
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
       const HomeScreen(),
       const ExploreScreen(purposeId: '',),
        SearchScreen(isBackButton: false,),
       const SavedScreen(),
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
      child: WillPopScope(
        onWillPop: Get.find<AuthController>().handleOnWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: !GetPlatform.isMobile ? null : FloatingActionButton(
            elevation: 5,
            backgroundColor: _pageIndex == 2 ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            onPressed: () => _setPage(2),
            child: Icon(
              CupertinoIcons.search, size: Dimensions.paddingSize34,
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
                BottomNavItem(img: Images.navBarHome, isSelected: _pageIndex == 0, tap: () => _setPage(0), title: 'Home',),
                BottomNavItem(img: Images.navBarExplore, isSelected: _pageIndex == 1, tap: () => _setPage(1), title: 'Explore',),
                const Expanded(child: SizedBox()),
                BottomNavItem(img: Images.navBarSave, isSelected: _pageIndex == 3, tap: () => _setPage(3), title: 'Saved',),
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
