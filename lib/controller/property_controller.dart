import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/location_controller.dart';
import 'package:get_my_properties/data/models/body/vendor_locality.dart';
import 'package:get_my_properties/data/models/response/property_detail_model.dart';
import 'package:get_my_properties/data/models/response/property_model.dart';
import 'package:get_my_properties/data/models/response/recent_search_model.dart';
import 'package:get_my_properties/data/models/response/vendor_property_model.dart';
import 'package:get_my_properties/data/repo/property_repo.dart';
import 'package:get_my_properties/features/screens/dashboard/seller_dashboard.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PropertyController extends GetxController implements GetxService {
  final PropertyRepo propertyRepo;

  PropertyController({required this.propertyRepo,});

  bool _isLoading = false;
  bool get isLoading => _isLoading;



  XFile? _pickedDisplayImage;
  XFile? get pickedDisplayImage => _pickedDisplayImage;

  void pickDisplayImage({required bool isRemove}) async {
    if (isRemove) {
      _pickedDisplayImage = null;
    } else {
      _pickedDisplayImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    update();
  }
  List<XFile> _pickedGalleryImages = [];
  List<XFile> get pickedGalleryImages => _pickedGalleryImages;

  // Method to pick a single image
  Future<void> pickGalleryImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        _pickedGalleryImages.add(image);
        update();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Method to remove an image by index
  void removeImage(int index) {
    _pickedGalleryImages.removeAt(index);
    update();
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
    _isPropertyLoading = true;
    update();
  }
  bool _isPropertyLoading = false;
  bool get isPropertyLoading => _isPropertyLoading;

  List<PropertyModel>? _propertyList;
  List<PropertyModel>? get propertyList => _propertyList;

  // List<PropertyModel>? _topPropertyList;
  // List<PropertyModel>? get topPropertyList => _topPropertyList;
  //
  // List<PropertyModel>? _featuredPropertyList;
  // List<PropertyModel>? get featuredPropertyList => _featuredPropertyList;

  List<LatLng> markerCoordinates = [];
  Future<void> getPropertyList({
    String? page,
    String? stateId,
    String? cityId,
    String? localityId,
    String? purposeId,
    String? categoryId,
    String? amenityId,
    String? typeId,
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
    _isPropertyLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _propertyList = []; // Reset product list for the first page
        _topPropertyList = [];
        _featuredPropertyList = [];
        update();
      }
      if (!_pageList.contains(page)) {
        _pageList.add(page!);

        Response response = await propertyRepo.getUserProperty(
          stateId: stateId,
          cityId: cityId,
          localityId: localityId,
          purposeId: purposeId,
          categoryId: categoryId,
          amenityId: amenityId,
          typeId: typeId,
          page: page,
          limit: '20',
          userId: userId,
          minPrice: minPrice,
          maxPrice: maxPrice,
          sortBy: sortBy,
          lat: lat,
          long: long,
          direction: direction,
          bathroom: bathroom,
          space: space,
        );

        if (response.statusCode == 200) {
          List<dynamic> dataList = response.body['data'];
          List<PropertyModel> newDataList = dataList.map((json) => PropertyModel.fromJson(json)).toList();

          if (page == '1') {

            _propertyList = newDataList;
          } else {
            _propertyList!.addAll(newDataList);
          }

          // List<PropertyModel> topProperties = newDataList.where((property) => property.topProperty == true).toList();
          // if (topProperties.isNotEmpty) {
          //   _topPropertyList!.addAll(topProperties);
          // }
          //
          // List<PropertyModel> featuredProperties = newDataList.where((property) => property.isFeatured == true).toList();
          // if (topProperties.isNotEmpty) {
          //   _featuredPropertyList!.addAll(featuredProperties);
          // }

          markerCoordinates = newDataList.map((property) {
            double latitude =  property.latitude ?? 0;
            double longitude = property.longitude ?? 0;

            return LatLng(latitude, longitude);
          }).toList();
            print(' ============>>${markerCoordinates.length}');
          _isPropertyLoading = false;
          update();
        } else {

        }
      } else {
        if (_isPropertyLoading) {
          _isPropertyLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching property list: $e');
      _isPropertyLoading = false;
      update();
    }
  }





  PropertyDetailModel? _propertyDetails;
  PropertyDetailModel? get propertyDetails => _propertyDetails;


  Future<PropertyDetailModel?> getPropertyDetailsApi(String? propertyId) async {
    _isLoading = true;
    _propertyDetails = null;
    update();
    Response response = await propertyRepo.getPropertyDetails(propertyId);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.body['data'];
      _propertyDetails = PropertyDetailModel.fromJson(responseData);
    } else {
    }
    _isLoading = false;
    update();
    return _propertyDetails;
  }


  /// ######  VENDOR  ##########////
///

  List<VendorPropertyModel>? _verderPropertyList;
  List<VendorPropertyModel>? get verdorPropertyList => _verderPropertyList;

  Future<void> getVendorPropertyList({
    String? page,
    String? status,

  }) async {
    _isPropertyLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _verderPropertyList = []; // Reset product list for the first page
        update();
      }

      if (!_pageList.contains(page)) {
        _pageList.add(page!);
        Response response = await propertyRepo.getVendorProperty(status);
        if (response.statusCode == 200) {
          List<dynamic> dataList = response.body['data'];
          List<VendorPropertyModel> newDataList = dataList.map((json) => VendorPropertyModel.fromJson(json)).toList();

          if (page == '1') {
            _verderPropertyList = newDataList;
          } else {
            _verderPropertyList!.addAll(newDataList);
          }

          _isPropertyLoading = false;
          update();
        } else {
          // Handle the error appropriately
        }
      } else {
        if (_isPropertyLoading) {
          _isPropertyLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching property list: $e');
      _isPropertyLoading = false;
      update();
    }
  }

  Future<dynamic> postPropertyApi({
    required String typeId,
    required String purposeId,
    required String categoryId,
    required String amenityId,
    required String slug,
    required String title,
    required String description,
    required String metaTitle,
    required String metaDesc,
    required String address,
    required String unit,
    required String videoLink,
    required String room,
    required String space,
    required String bedroom,
    required String bathroom,
    required String floor,
    required String kitchen,
    required String buildYear,
    required String area,
    required String direction,
    required String price,
    required String marketPrice,
    required String isFeatured,
    required String topProperty,
    required String expiryDate,
    required String stateId,
    required String cityId,
    required List<LocalityMapData> localityId,
    // required String localityId,
    required String latitude,
    required String longitude,
    required XFile? displayImage,
    required List<XFile>? galleryImages,
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
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConstants.baseUrl}${AppConstants.vendorPropertyUrl}'),
    );

    request.fields.addAll({
      "type_id": typeId,
      "purpose_id": purposeId,
      "category_id": categoryId,
      "amenity_id": jsonEncode(["66b0999290ff51eb47b9bb13"]),
      "slug": slug,
      "title": title,
      "description": description,
      "meta_title": metaTitle,
      "meta_description": metaDesc,
      "address": address,
      "unit": unit,
      "video_link": videoLink,
      "room": room,
      "space": space,
      "bedroom": bedroom,
      "bathroom": bathroom,
      "floor": floor,
      "kitchen": kitchen,
      "built_year": buildYear,
      "area": area,
      "direction": direction,
      "price": price,
      "market_price": marketPrice,
      "is_featured": isFeatured,
      "top_property": topProperty,
      "expiry_date": expiryDate,
      "state_id": stateId,
      "city_id": cityId,
      // "locality_id": localityId,
      // "locality_id": jsonEncode(["66b09b8fc7068370892553c0", "66b09b9bc7068370892553c3"]),
      "latitude": latitude,
      "longitude": longitude,
    });

    // Add display image if it exists
    if (displayImage != null && displayImage.path.isNotEmpty) {
      var mimeType = displayImage.path.split('.').last; // e.g., jpg, png
      request.files.add(await http.MultipartFile.fromPath(
        'property_display_image', // Ensure this field name matches what the API expects
        displayImage.path,
        contentType: MediaType('image', mimeType),
      ));
    }

    // Add gallery images if they exist
    if (galleryImages != null && galleryImages.isNotEmpty) {
      for (var image in galleryImages) {
        if (image.path.isNotEmpty) {
          var mimeType = image.path.split('.').last; // e.g., jpg, png
          request.files.add(await http.MultipartFile.fromPath(
            'gallery_images', // Ensure this field name matches what the API expects
            image.path,
            contentType: MediaType('image', mimeType),
          ));
        }
      }
    }

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      // Print the request details for debugging
      print('Request URL: ${request.url}');
      print('Request Method: ${request.method}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files}');

      var responseBody = await response.stream.bytesToString();
      print('Raw Response Body: $responseBody'); // Print raw response for debugging
      showCustomSnackBar('Property Created Successfully You will notify when Admin Approved your listing');


      // Try to decode response as JSON
      try {
        return jsonDecode(responseBody);
      } catch (jsonError) {
        print('JSON Decode Error: $jsonError');
        print('Response Body (raw): $responseBody');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    } finally {
      // Get.to(() => SellerDashboardScreen(pageIndex: 0));
      Get.find<AuthController>().getHomeDataApi();
      Get.find<LocationController>().getCountryList();
      Get.find<LocationController>().getStateList();
      Get.find<LocationController>().getCityList('66b356ec18a20385edf487a7');
      Get.find<LocationController>().getLocalityList();
      _isLoading = false;
      update();
    }
  }

  //
  // List<PropertyModel>? _searchPropertyList;
  // List<PropertyModel>? get searchPropertyList => _searchPropertyList;
  // List<SearchPropertyModel>? _searchPropertyList;
  // List<SearchPropertyModel>? get searchPropertyList => _searchPropertyList;

  Future<void> clearSearchPropertyList() async {
    _propertyList = [];
    update();
  }
  Future<void> getSearchPropertyList({
    String? page,
    String? limit,
    String? latitude,
    String? longitude,
    String? query,
    String? purposeId,



  }) async {
    _isPropertyLoading = true;
    try {
      if (page == '1') {
        _pageList = [];
        _offset = 1;
        _propertyList = [];
        update();
      }
      if (!_pageList.contains(page)) {_pageList.add(page!);
        Response response = await propertyRepo.userSearchPropertyRepo(
            page, limit, latitude, longitude, query,purposeId,
            Get.find<AuthController>().profileData!.sId.toString());
        if (response.statusCode == 200) {
          List<dynamic> dataList = response.body['data'];
          List<PropertyModel> newDataList = dataList.map((json) => PropertyModel.fromJson(json)).toList();

          if (page == '1') {
            _propertyList = newDataList;
          } else {
            _propertyList!.addAll(newDataList);
          }

          _isPropertyLoading = false;
          update();
        } else {
          // Handle the error appropriately
        }
      } else {
        if (_isPropertyLoading) {
          _isPropertyLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching search property list: $e');
      _isPropertyLoading = false;
      update();
    }
  }


  List<RecentSearchModel>? _recentSearchList;
  List<RecentSearchModel>? get recentSearchList => _recentSearchList;
  Future<void> getRecentSearchList() async {
    _isLoading = true;
    update();
    try {
      Response response = await propertyRepo.userRecentSearchRepo();
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.body['data'];
        _recentSearchList = responseData.map((json) => RecentSearchModel.fromJson(json)).toList();
      } else {
        print("Errror in Country Load");
      }
    } catch (error) {
      print("Error while fetching Country  list: $error");
    }
    _isLoading = false;
    update();
  }

  Future<void> deleteVenderProperty(propertyId,String? propertyStatus) async {
    _isLoading = true;
    update();
    try {
      Response response = await propertyRepo.vendorDeletePropertyRepo(propertyId);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.body;
        if (responseData['status'] == true) {
          showCustomSnackBar(responseData['message']);

        }
      } else {
        // Handle error if status code is not 200
        showCustomSnackBar("Error in deleting property", isError: true);
      }
    } catch (error) {
      print("Error while deleting property: $error");
      showCustomSnackBar("An error occurred", isError: true);
    }
    getVendorPropertyList(page: '1', status: propertyStatus);


    _isLoading = false;
    update();
  }



  // top and popular property //

  List<PropertyModel>? _topPropertyList;
  List<PropertyModel>? get topPropertyList => _topPropertyList;

  List<PropertyModel>? _featuredPropertyList;
  List<PropertyModel>? get featuredPropertyList => _featuredPropertyList;


  Future<void> getTopPopularPropertyList({
    String? page,
    String? stateId,
    String? cityId,
    String? localityId,
    String? purposeId,
    String? categoryId,
    String? amenityId,
    String? typeId,
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
    _isPropertyLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _propertyList = []; // Reset product list for the first page
        _topPropertyList = [];
        _featuredPropertyList = [];
        update();
      }
      if (!_pageList.contains(page)) {
        _pageList.add(page!);

        Response response = await propertyRepo.getUserProperty(
          stateId: stateId,
          cityId: cityId,
          localityId: localityId,
          purposeId: purposeId,
          categoryId: categoryId,
          amenityId: amenityId,
          typeId: typeId,
          page: page,
          limit: '20',
          userId: userId,
          minPrice: minPrice,
          maxPrice: maxPrice,
          sortBy: sortBy,
          lat: lat,
          long: long,
          direction: direction,
          bathroom: bathroom,
          space: space,
        );

        if (response.statusCode == 200) {
          List<dynamic> dataList = response.body['data'];
          List<PropertyModel> newDataList = dataList.map((json) => PropertyModel.fromJson(json)).toList();



          List<PropertyModel> topProperties = newDataList.where((property) => property.topProperty == true).toList();
          if (topProperties.isNotEmpty) {
            _topPropertyList!.addAll(topProperties);
          }

          List<PropertyModel> featuredProperties = newDataList.where((property) => property.isFeatured == true).toList();
          if (topProperties.isNotEmpty) {
            _featuredPropertyList!.addAll(featuredProperties);
          }

          _isPropertyLoading = false;
          update();
        } else {

        }
      } else {
        if (_isPropertyLoading) {
          _isPropertyLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching property list: $e');
      _isPropertyLoading = false;
      update();
    }
  }
}
