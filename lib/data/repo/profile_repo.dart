import 'dart:async';
import 'package:get_my_properties/data/api/api_client.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient,});
  Future<Response> updateProfile(String? name,String? email,String? address, XFile? image,) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'name': name.toString(),
      'email': email.toString(),
      'address': address.toString(),
    });
    return apiClient.postMultipartData(
      AppConstants.userProfileUpdateUrl , fields, [MultipartBody('profile_image', image)], [],
    );
  }


}
