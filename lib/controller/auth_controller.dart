import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_my_properties/data/models/response/admin_dashboard_model.dart';
import 'package:get_my_properties/data/models/response/home_data_model.dart';
import 'package:get_my_properties/data/models/response/profile_data_model.dart';
import 'package:get_my_properties/data/repo/auth_repo.dart';
import 'package:get_my_properties/features/screens/Maps/location_view.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;
  AuthController({required this.authRepo,required this.sharedPreferences, }) ;

  int _loginType = 0;
  int get loginType => _loginType;

  void selectLoginType(int index) {
    _loginType = index;
    print(loginType);
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool isCustomerLoggedIn() {
    return isLoggedIn() && authRepo.getLoginType() == 0;
  }

  bool isVendorLoggedIn() {
    return isLoggedIn() && authRepo.getLoginType() == 1;
  }

  Future<void> saveLatitude(double latitude) async {
    await sharedPreferences.setDouble(AppConstants.latitude, latitude);
  }

  double? getLatitude() {
    return sharedPreferences.getDouble(AppConstants.latitude);
  }

  Future<void> saveLongitude(double latitude) async {
    await sharedPreferences.setDouble(AppConstants.longitude, latitude);
  }

  double? getLongitude() {
    return sharedPreferences.getDouble(AppConstants.longitude);
  }

  Future<void> saveAddress(String address) async {
    await sharedPreferences.setString(AppConstants.address, address);
  }

  String? getSaveAddress() {
    return sharedPreferences.getString(AppConstants.address);
  }



  bool _isLoading = false;
  bool get isLoading => _isLoading;


  static final List<String> _loginTypeList = ['customer',"vendor"];
  List<String> get loginTypeList => _loginTypeList;


  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  Future<void> userLoginApi(String phoneNo, {bool isVendor = false}) async {
    _isLoginLoading = true;
    update();

    final String url = isVendor
        ?  '${AppConstants.baseUrl}${AppConstants.vendorLoginUrl}'
        : '${AppConstants.baseUrl}${AppConstants.userLoginUrl}';

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone_number': phoneNo,
           'user_type' : isVendor ? 'vender' : 'customer'
        }),
      );

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          String otp = responseData['data']['otp'].toString();
          Get.toNamed(RouteHelper.getOtpVerificationRoute(phoneNo));
          showCustomSnackBar('OTP: $otp');
        } else {
          String errorMessage = responseData['message'] ?? 'Something went wrong.';
          print("Error: $errorMessage");
          showCustomSnackBar(errorMessage);
        }

    _isLoginLoading = false;
    update();
  }




  // Future<void> userLoginApi(String phoneNo, bool isVendor = false) async {
  //   _isLoginLoading = true;
  //   update();
  //
  //   try {
  //     Response response = await authRepo.userLoginRepo(phoneNo);
  //     var responseData = response.body;
  //
  //     if (responseData["status"] == true) {
  //       String otp = responseData['data']['otp'].toString();
  //       Get.toNamed(RouteHelper.getOtpVerificationRoute(phoneNo));
  //       showCustomSnackBar('OTP: $otp');
  //     } else {
  //       showCustomSnackBar(responseData['message']);
  //     }
  //   } catch (e) {
  //     showCustomSnackBar('An error occurred, please try again.');
  //   } finally {
  //     _isLoginLoading = false;
  //     update();
  //   }
  // }

  Future<void> userOtpApi(String? phoneNo,String? otp,{bool isVendor = false}) async {
    _isLoginLoading = true;
    update();
    try {
      Response response;
      if (isVendor) {
        response = await authRepo.vendorLoginVerifyOtp(phoneNo, otp);
      } else {
        response = await authRepo.userLoginVerifyOtp(phoneNo, otp);
      }

      var responseData = response.body;
      if (responseData["status"] == true) {
        authRepo.saveUserToken(responseData['data']['token']);
        await authRepo.saveLoginType(isVendor ? 1 : 0);
        if (isVendor) {
          Get.toNamed(RouteHelper.getAdminDashboardRoute());
        } else {
          Get.toNamed(RouteHelper.getLocationPickerRoute());
          // Get.toNamed(RouteHelper.getDashboardRoute());
        }
      } else {
        showCustomSnackBar(responseData['message']);
      }
    } catch (e) {
      showCustomSnackBar('An error occurred, please try again.');
    } finally {
      _isLoginLoading = false;
      update();
    }
  }

  bool _profileDetailsLoading = false;
  bool get profileDetailsLoading => _profileDetailsLoading;


  ProfileDataModel? _profileData;
  ProfileDataModel? get profileData => _profileData;


  Future<ProfileDataModel?> profileDetailsApi({bool isVendor = false}) async {
    _profileDetailsLoading = true;
    _profileData = null;
    update();
    // Response response = await authRepo.getUserData();
    Response response;
    if (isVendor) {
      print('vendor');
      response = await authRepo.getVendorData();
    } else {
      print('customer');
      response =  await authRepo.getUserData();
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data']; // Change List<dynamic> to Map<String, dynamic>
      _profileData = ProfileDataModel.fromJson(responseData);
    } else {
    }
    _profileDetailsLoading = false;
    update();
    return _profileData;
  }

  String _propertyTypeID = '';
  String get propertyTypeID => _propertyTypeID;

  void selectPropertyTypeId(String val) {
    _propertyTypeID = val;
    update();
  }

  List<String> _propertyTypeIDs = [];
  List<String> get propertyTypeIDs => _propertyTypeIDs;

  void selectPropertyTypeIds(String val) {
    if (_propertyTypeIDs.contains(val)) {
      _propertyTypeIDs.remove(val); // Deselect the item
    } else {
      _propertyTypeIDs.add(val); // Select the item
    }
    update();
  }

  // List<String> _propertyIDs = [];
  // List<String> get propertyTypeIDs => _propertyTypeIDs;
  //
  // void selectPropertyTypeIds(String val) {
  //   if (_propertyTypeIDs.contains(val)) {
  //     _propertyTypeIDs.remove(val); // Deselect the item
  //   } else {
  //     _propertyTypeIDs.add(val); // Select the item
  //   }
  //   update();
  // }

  String _propertyPurposeID = '';
  String get propertyPurposeID => _propertyPurposeID;
  void selectPropertyPurposeId(String val) {
    _propertyPurposeID = val;
    update();
  }

  String _propertyCategoryId = '';
  String get propertyCategoryId => _propertyCategoryId;
  void selectPropertyCategoryId(String val) {
    _propertyCategoryId = val;
    update();
  }

  String ? _amenityId;
  String? get amenityId => _amenityId;

  void setAmenityId(String val) {
    _amenityId = val;
    update();
  }

  List<String> _amenityIds = [];
  List<String> get amenityIds => _amenityIds;

  void setAmenityIds(String val) {
    if (_amenityIds.contains(val)) {
      _amenityIds.remove(val); // Deselect the item
    } else {
      _amenityIds.add(val); // Select the item
    }
    update();
  }


  TypeDataModel? _homeData;
  TypeDataModel? get homeData => _homeData;


  Future<TypeDataModel?> getHomeDataApi() async {
    _isLoading = true;
    _homeData = null;
    update();
    Response response = await authRepo.getHomeDataRepo();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data'];
      _homeData = TypeDataModel.fromJson(responseData);
      if (_homeData != null) {
        // _propertyTypeID = homeData!.propertyTypes![0].sId!;
        // _propertyPurposeID = homeData!.propertyPurposes![0].sId!;
        // _propertyCategoryId = homeData!.propertyCategory![0].sId!;
        // _amenityId = homeData!.propertyAmenities![0].sId!;
      }
    } else {
    }
    _isLoading = false;
    update();
    return _homeData;
  }

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  void pickImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedImage = null;
    } else {
      _pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }


  VendorDashboardModel? _vendorDashboardData;
  VendorDashboardModel? get vendorDashboardData => _vendorDashboardData;


  Future<VendorDashboardModel?> getVendorDataApi() async {
    _isLoading = true;
    _vendorDashboardData = null;
    update();
    Response response = await authRepo.getVendorDashboardDataRepo();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data'];
      _vendorDashboardData = VendorDashboardModel.fromJson(responseData);
    } else {
    }
    _isLoading = false;
    update();
    return _vendorDashboardData;
  }

  DateTime? lastBackPressTime;

  Future<bool> handleOnWillPop() async {
    final now = DateTime.now();

    if (lastBackPressTime == null || now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
      updateLastBackPressTime(now);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      SystemNavigator.pop();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void updateLastBackPressTime(DateTime time) {
    lastBackPressTime = time;
    update();
  }

  DateTime? _lastBackPressTime;

  Future<bool> willPopCallback() async {
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      Get.showSnackbar(
        GetSnackBar(
          message: 'Press back again to exit',
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    SystemNavigator.pop(); // Closes the app
    update();
    return Future.value(true);
  }

}