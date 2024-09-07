import 'dart:async';
import 'package:get_my_properties/data/api/api_client.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient,});


  Future<Response> userSearchSuggestionRepo(String? query,) async {
    return await apiClient.getData(AppConstants.userSearchSuggestionUrl, body: {"query": query,},method : 'POST');
  }




}