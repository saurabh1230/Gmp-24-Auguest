import 'dart:async';
import 'package:get_my_properties/data/api/api_client.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get/get.dart';


class InquiryRepo {
  final ApiClient apiClient;
  InquiryRepo({required this.apiClient,});



  Future<Response> userPropertyInquiryRepo(String? propertyID,String? name,String? phoneNo,String? email,String? message,) async {
    return await apiClient.postData(AppConstants.userCreateInquiryUrl, {
      "property_id": propertyID, "name" : name, "phone_number": phoneNo, "email" : email, "message" : message
    });
  }
  Future<Response> getUserInquiryRepo() {
    return apiClient.getData(AppConstants.userCreateInquiryUrl,method: 'GET');
  }

  Future<Response> getVendorInquiryRepo() {
    return apiClient.getData(AppConstants.vendorAllEnquiryUrl,method: 'GET');
  }

  Future<Response> getVendorInquiryReplyRepo(String? propertyId,String? status,) {
    return apiClient.getData(AppConstants.vendorAllEnquiryUrl,method: 'PATCH',body: {
      "id": propertyId,
      "status": status
    });
  }




}
