import 'dart:async';
import 'package:get_my_properties/data/api/api_client.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


class PropertyRepo {
  final ApiClient apiClient;

  PropertyRepo({required this.apiClient,});

  Future<Response> getUserProperty({
    String? stateId,
    String? cityId,
    String? localityId,
    String? purposeId,
    String? categoryId,
    String? amenityId,
    String? typeId,
    String? page,
    String? limit,
    String? userId,
    String? minPrice,
    String? maxPrice,
    String? sortBy,
    String? lat,
    String? long,
    String? direction,
    String? bathroom,
    String? space,
  }) async {
    // Initialize the map to hold the fields
    Map<String, dynamic> fields = {}; // Changed to dynamic to allow different data types

    // Add fields conditionally based on their presence
    if (stateId != null) fields['state_id'] = stateId;
    if (cityId != null) fields['city_id'] = cityId;
    if (localityId != null) fields['locality_id'] = localityId;
    if (purposeId != null) fields['purpose_id'] = purposeId;
    if (categoryId != null) fields['category_id'] = categoryId;
    if (amenityId != null) fields['amenity_id'] = amenityId;
    if (typeId != null) fields['type_id'] = typeId;
    if (minPrice != null) fields['min_price'] = minPrice;
    if (maxPrice != null) fields['max_price'] = maxPrice;
    if (page != null) fields['page'] = page;
    if (limit != null) fields['limit'] = limit;
    if (sortBy != null) fields['sort_by'] = sortBy;

    // Convert lat and long to double, if provided
    if (lat != null) fields['lat'] = double.tryParse(lat) ?? lat;
    if (long != null) fields['long'] = double.tryParse(long) ?? long;

    if (direction != null) fields['direction'] = direction;
    if (bathroom != null) fields['bathroom'] = bathroom;
    if (space != null) fields['space'] = space;
    if (userId != null) fields['user_id'] = userId;

    // Make the API request
    try {
      Response response = await apiClient.postData(
        AppConstants.userGetPropertyUrl,
        fields,
      );

      if (response.statusCode == 200) {
        print('API call successful.');
      } else {
        print('API call failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      return response;
    } catch (e) {
      print('Error making API call: $e');
      rethrow; // You can choose to rethrow the error or handle it differently
    }
  }


  Future<Response> getPropertyDetails(String? propertyId) {
    print('${AppConstants.userPropertyDetails}$propertyId');
    return apiClient.getData(
        '${AppConstants.userPropertyDetails}$propertyId', method: 'GET');
  }

  ///###### VENDOR PROPERTY
  Future<Response> getVendorProperty(
      String? status
      ) async {

    return apiClient.getData(
        '${AppConstants.vendorPropertyUrl}?status=$status', method: 'GET'
      // fields,
    );
  }


  Future<Response> postPropertyRepo(XFile? displayImage,
      XFile? galleryImages,) async {
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      '_method': 'put',
      "type_id": "66b097b88e94ad0e435526f8",
      "purpose_id": "66b097878e94ad0e435526ea",
      "category_id": "66b0989dd364d1b52a30f1c7",
      "amenity_id": "66b0999290ff51eb47b9bb13",
      "slug": "for-sale-in-the-world-towers-lower-parel",
      "title": "For Sale in The World Towers, Lower Parel",
      "description": "description",
      "meta_title": "meta-title",
      "meta_description": "meta_description",
      "address": "South Mumbai, Maharashtra, Mumbai, Maharastra, India",
      "unit": '1',
      "video_link": "",
      "room": "1",
      "space": "1",
      "bedroom": "1",
      "bathroom": "1",
      "floor": "1",
      "kitchen": "1",
      "built_year": "2010",
      "area": "1000",
      "direction": "east",
      "price": "20000",
      "market_price": "15000",
      "is_featured": "true",
      "top_property": "false",
      "expiry_date": "2034",
      "state_id": "66b356ec18a20385edf487c0",
      "city_id": "66b356f018a20385edf4a4d9",
      "locality_id": "66b09b8fc7068370892553c0",
      "latitude": "18.5204",
      "longitude": "73.8567"
    });
    return apiClient.postMultipartData(
      AppConstants.vendorPropertyUrl, fields,
      [MultipartBody('property_display_image', displayImage),
        MultipartBody('gallery_images', galleryImages)], [],
    );
  }

  Future<Response> userSearchPropertyRepo(String? page, String? limit,
      String? latitude, String? longitude, String? query,String? purposeId, String? userId,) async {
    return await apiClient.postData(AppConstants.userSearchPropertyUrl, {
      "page": page,
      "limit": limit,
      "lat": latitude,
      "long": longitude,
      "query": query,
      "purpose_id": purposeId,
      "user_id": userId,
    });
  }

  Future<Response> userRecentSearchRepo() async {
    return await apiClient.getData(AppConstants.userSearchPropertyUrl,method: 'GET');
  }



  Future<Response> userBookmarkPropertyRepo(String? propertyId,) async {
    return await apiClient.postData(AppConstants.userBookmarkPropertyUrl, {"property_id": propertyId, });
  }

  Future<Response> userBookmarkPropertyListRepo() async {
    return await apiClient.getData(AppConstants.userBookmarkPropertyUrl,method: 'GET');
  }

  Future<Response> vendorDeletePropertyRepo(String propertyId) async {
    return await apiClient.getData('${AppConstants.vendorPropertyUrl}/$propertyId',method: 'DELETE');
  }



}