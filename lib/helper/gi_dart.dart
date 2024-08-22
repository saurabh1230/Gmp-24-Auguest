
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/bookmark_controller.dart';
import 'package:get_my_properties/controller/explore_controller.dart';
import 'package:get_my_properties/controller/home_controller.dart';
import 'package:get_my_properties/controller/location_controller.dart';
import 'package:get_my_properties/controller/profile_controller.dart';
import 'package:get_my_properties/controller/properties_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/controller/vendor_controller.dart';
import 'package:get_my_properties/data/api/api_client.dart';
import 'package:get_my_properties/data/repo/auth_repo.dart';
import 'package:get_my_properties/data/repo/location_repo.dart';
import 'package:get_my_properties/data/repo/profile_repo.dart';
import 'package:get_my_properties/data/repo/property_repo.dart';
import 'package:get_my_properties/data/repo/vendor_repo.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void>   init() async {
  /// Repository
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));




  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => PropertyRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find()));
  Get.lazyPut(() => VendorRepo(apiClient: Get.find()));


  /// Controller

  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ExploreController());
  // Get.lazyPut(() => PropertiesController());
  Get.lazyPut(() => ProfileController(profileRepo: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => AuthController(authRepo:  Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => PropertyController(propertyRepo:  Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:  Get.find()));
  Get.lazyPut(() => VendorController(vendorRepo:  Get.find()));
  Get.lazyPut(() => BookmarkController(propertyRepo:  Get.find()));


}
