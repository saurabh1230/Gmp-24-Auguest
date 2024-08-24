import 'package:get/get.dart';
import 'package:get_my_properties/data/models/response/bookmarked_property_model.dart';
import 'package:get_my_properties/data/models/response/property_model.dart';
import 'package:get_my_properties/data/repo/property_repo.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkController extends GetxController implements GetxService {
  final PropertyRepo propertyRepo;

  BookmarkController({required this.propertyRepo});

  List<PropertyModel?>? _bookmarkList = [];
  List<PropertyModel?>? get bookmarkList => _bookmarkList;

  List<String?> _bookmarkIdList = [];
  List<String?> get bookmarkIdList => _bookmarkIdList;

  @override
  void onInit() {
    super.onInit();
    _loadBookmarks();
  }

  Future<void> _saveBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkIds = _bookmarkIdList.where((id) => id != null).cast<String>().toList();
    await prefs.setStringList('bookmarked_property_ids', bookmarkIds);
  }

  Future<void> _loadBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedIds = prefs.getStringList('bookmarked_property_ids');
    if (savedIds != null) {
      _bookmarkIdList = savedIds;

    }
    update();
  }


  void addToBookmarkList(PropertyModel? propertyList) async {
    Response response = await propertyRepo.userBookmarkPropertyRepo(propertyList!.id);
    if (response.statusCode == 200) {
      _bookmarkList!.add(propertyList);
      _bookmarkIdList.add(propertyList.id);
      showCustomSnackBar('Property Saved', isError: false);
      await _saveBookmarks();
    }
    update();
  }

  Future<void> addToBookmarkById(String propertyId) async {
    Response response = await propertyRepo.userBookmarkPropertyRepo(propertyId);
    if (response.statusCode == 200) {
      if (!_bookmarkIdList.contains(propertyId)) {
        _bookmarkIdList.add(propertyId);
        showCustomSnackBar('Property Saved', isError: false);
        await _saveBookmarks();
      }
    }
    update();
  }
  Future<void> removeFromBookmarkById(String propertyId) async {
    Response response = await propertyRepo.userBookmarkPropertyRepo(propertyId);
    if (response.statusCode == 200) {
      int idIndex = _bookmarkIdList.indexOf(propertyId);
      if (idIndex != -1) {
        _bookmarkIdList.removeAt(idIndex);
        _bookmarkList!.removeWhere((property) => property?.id == propertyId);
        showCustomSnackBar('Property Unsaved', isError: false);
        await _saveBookmarks();
      }
    }
    update();
  }


  void removeFromBookMarkList(String? propertyId) async {
    Response response = await propertyRepo.userBookmarkPropertyRepo(propertyId);
    if (response.statusCode == 200) {
      int idIndex = _bookmarkIdList.indexOf(propertyId);
      if (idIndex != -1) {
        _bookmarkIdList.removeAt(idIndex);
        _bookmarkList!.removeWhere((property) => property?.id == propertyId);
      }
      showCustomSnackBar('Property Unsaved', isError: false);
      await _saveBookmarks();
    }
    update();
  }

  void removeSavedBookMarkList(String? propertyId) async {
    Response response = await propertyRepo.userBookmarkPropertyRepo(propertyId);
    if (response.statusCode == 200) {
      int idIndex = _bookmarkIdList.indexOf(propertyId);
      if (idIndex != -1) {
        _bookmarkIdList.removeAt(idIndex);
        _bookmarkList!.removeWhere((property) => property?.id == propertyId);
      }
      showCustomSnackBar('Property Unsaved', isError: false);
      await _saveBookmarks();
      Get.find<BookmarkController>().getBookmarkedPropertyList(page: '1',);
    }
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
    _isLoading = true;
    update();
  }
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<BookmarkPropertyModel>? _bookmarkedPropertyList;
  List<BookmarkPropertyModel>? get bookmarkedPropertyList => _bookmarkedPropertyList;


  Future<void> getBookmarkedPropertyList({
    String? page,
  }) async {
    _isLoading = true;
    try {
      if (page == '1') {
        _pageList = []; // Reset page list for new search
        _offset = 1;
        _bookmarkedPropertyList = []; // Reset property list for the first page
        update();
      }
      if (!_pageList.contains(page)) {
        _pageList.add(page!);

        Response response = await propertyRepo.userBookmarkPropertyListRepo();

        if (response.statusCode == 200) {
          List<dynamic> dataList = response.body['data']; // Change this line
          List<BookmarkPropertyModel> newDataList = dataList.map((json) {
            var propertyJson = json['property']; // Access 'property' field
            return BookmarkPropertyModel.fromJson(propertyJson);
          }).toList();

          if (page == '1') {
            _bookmarkedPropertyList = newDataList;
          } else {
            _bookmarkedPropertyList!.addAll(newDataList);
          }

          _isLoading = false;
          update();
        } else {
          // Handle the error appropriately
        }
      } else {
        if (_isLoading) {
          _isLoading = false;
          update();
        }
      }
    } catch (e) {
      print('Error fetching bookmark property list: $e');
      _isLoading = false;
      update();
    }
  }



}
