import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/data/models/response/inquiry_model.dart';
import 'package:get_my_properties/data/repo/inquiry_repo.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InquiryController extends GetxController implements GetxService {
  final InquiryRepo inquiryRepo;

  InquiryController({required this.inquiryRepo});



  bool _isLoading = false;
  bool get isLoading => _isLoading;

  var selectedDate = DateTime.now().obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  void updateTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  // Future<void> userPropertyInquiryApi(
  //     String? propertyID,String? name,String? phoneNo,String? email,String? message,) async {
  //   _isLoading = true;
  //   update();
  //   try {
  //     Response response;
  //     response = await inquiryRepo.userPropertyInquiryRepo(propertyID, name, phoneNo, email, message);
  //
  //     var responseData = response.body;
  //     // if (responseData["status"] == true) {
  //     //   showCustomSnackBar(responseData['message']);
  //     // } else {
  //     //   showCustomSnackBar('Please Try Again');
  //     // }
  //   } catch (e) {
  //     print('ch${e}');
  //     // showCustomSnackBar('An error occurred, please try again.');
  //   } finally {
  //     _isLoading = false;
  //     update();
  //   }
  // }

  Future<dynamic> userPropertyInquiryApi({
    required String propertyID,
    required String name,
    required String phoneNo,
    required String email,
    required String message,
    required String date,
    required String time,

  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    _isLoading = true;
    update();

    if (token == null || token.isEmpty) {
      print('Token is null or empty');
      _isLoading = false;
      update();
      return false;
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      "property_id": propertyID,
      "name": name,
      "phone_number": phoneNo,
      "email": email,
      "message": message,
      "date": date,
      "time": time,
    });

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.userCreateInquiryUrl}'),
        headers: headers,
        body: body,
      );

      print('Request URL: ${AppConstants.baseUrl}${AppConstants.userCreateInquiryUrl}');
      print('Request Headers: $headers');
      print('Request Body: $body');
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Response Body: ${response.body}');
        if (responseData["status"] == true) {
          showCustomSnackBar('Inquiry Created Successfully');
          return responseData;
        } else {
          showCustomSnackBar('Please Try Again');
          return false;
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    } finally {
      _isLoading = false;
      Get.back();
      update();
    }
  }

  int _offset = 1;
  int get offset => _offset;
  List<String> _pageList = [];
  int? _pageSize;
  int? get pageSize => _pageSize;

  void setOffset(int offset) {
    _offset= offset;
  }
  void showBottomLoader () {
    _isLoading = true;
    update();
  }


  List<InquiryModel>? _userInquiryList;
  List<InquiryModel>? get userInquiryList => _userInquiryList;

  Future<void> getUserInquiryList() async {
    _isLoading = true;
    update();
    try {
      Response response;
      if (Get.find<AuthController>().isCustomerLoggedIn()) {
        response = await inquiryRepo.getUserInquiryRepo();
      } else {
        response = await inquiryRepo.getVendorInquiryRepo();
      }
      // var responseData = response.body;
      // Response response = await inquiryRepo.getUserInquiryRepo();

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _userInquiryList = responseData.map((json) => InquiryModel.fromJson(json)).toList();
      } else {
        print("Error in _userInquiryList Load");
      }
    } catch (error) {
      print("Error while fetching _userInquiryList list: $error");
    }
    _isLoading = false;
    update();
  }

  // Future<void> vendorInquiryReplyApi(String? propertyId,String? status) async {
  //   _isLoading = true;
  //   update();
  //   try {
  //     Response response = await inquiryRepo.getVendorInquiryReplyRepo(propertyId,status);
  //
  //     var responseData = response.body;
  //     if (responseData["status"] == true) {
  //       showCustomSnackBar('Status Updated Successfully');
  //     } else {
  //       showCustomSnackBar(responseData['message']);
  //     }
  //   } catch (e) {
  //     showCustomSnackBar('An error occurred, please try again.');
  //   } finally {
  //     _isLoading = false;
  //     update();
  //   }
  // }
  //

  Future<dynamic> vendorInquiryReplyApi({
    required String propertyID,
    required String status,
  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);

    _isLoading = true;
    update();

    if (token == null || token.isEmpty) {
      print('Token is null or empty');
      _isLoading = false;
      update();
      return false;
    }

    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      "id": propertyID,
      "status": status
    });

    try {
      final response = await http.patch(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.vendorAllEnquiryUrl}'),
        headers: headers,
        body: body,
      );

      print('Request URL: ${AppConstants.baseUrl}${AppConstants.vendorAllEnquiryUrl}');
      print('Request Headers: $headers');
      print('Request Body: $body');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Response Body: ${response.body}');
        if (responseData["status"] == true) {
          showCustomSnackBar('Inquiry Created Successfully');
          return responseData;
        } else {
          showCustomSnackBar('Please Try Again');
          return false;
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    } finally {
      _isLoading = false;
      Get.back();
      update();
    }
  }




// Future<void> getUserInquiryList({
  //   String? page,
  // }) async {
  //   _isLoading = true;
  //   try {
  //     if (page == '1') {
  //       _pageList = [];
  //       _offset = 1;
  //       _userInquiryList = [];
  //       update();
  //     }
  //     if (!_pageList.contains(page)) {
  //       _pageList.add(page!);
  //
  //       Response response = await inquiryRepo.getUserInquiryRepo();
  //       print('Response: ${response.body}');
  //
  //       if (response.statusCode == 200) {
  //         List<dynamic> dataList = response.body['data'];
  //         List<InquiryModel> newDataList = dataList.map((json) => InquiryModel.fromJson(json)).toList();
  //         if (page == '1') {
  //
  //           _userInquiryList = newDataList;
  //         } else {
  //           _userInquiryList!.addAll(newDataList);
  //         }
  //
  //         _isLoading = false;
  //         update();
  //       } else {
  //
  //       }
  //     } else {
  //       if (_isLoading) {
  //         _isLoading = false;
  //         update();
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching inquiry list: $e');
  //     _isLoading = false;
  //     update();
  //   }
  // }
  //




}
