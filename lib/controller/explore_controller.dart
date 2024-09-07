import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:intl/intl.dart';
class ExploreController extends GetxController implements GetxService {
  ExploreController();

  int _selectedButton = 0;
  int get selectedButton => _selectedButton;

  void selectButton(int index) {
    _selectedButton = index;
    update();
  }

  int _propertyTypeIndex = 0;
  int get propertyTypeIndex => _propertyTypeIndex;

  void selectPropertyType(int index) {
    _propertyTypeIndex = index;
    update();
  }




  static final List<String> _propertyFor = ['Rent', "Buy"];
  List<String> get propertyFor => _propertyFor;

  static final List<String> _propertyType = ['Apartment', "House", "Multi-family", "PG", "Plot/ Land", "Multi Story"];
  List<String> get propertyType => _propertyType;

  int _spaceTypeIndex = 0;
  int get spaceTypeIndex => _spaceTypeIndex;

  void selectSpaceType(int index) {
    _spaceTypeIndex = index;
    update();
  }

  final List<String> spaceType = ['1', '2', '3', '4', '5', '6', '7', '+8'];

  String _selectedDirection = '';
  String get selectedDirection => _selectedDirection;
  void selectDirection(String val) {
    _selectedDirection = val;
    update();
  }
  final List<String> directionList = [
    "east",
    "west",
    "north",
    "south ",
  ];

// Convert the list of directions to a list of DropdownMenuItem<String>


  String _spaceTypeID = '';
  String get spaceTypeID => _spaceTypeID;
  void selectSpaceTypeID(String val) {
    _spaceTypeID = val;
    update();
  }


  List<String> _spaceTypeIDs = [];
  List<String> get spaceTypeIDs => _spaceTypeIDs;

  void selectSpaceTypeIDs(String val) {
    if (_spaceTypeIDs.contains(val)) {
      _spaceTypeIDs.remove(val); // Deselect the item
    } else {
      _spaceTypeIDs.add(val); // Select the item
    }
    update();
  }

  final List<String> bathroomType = ['1', '2', '3', '+4'];
  String _bathroomID = '';
  String get bathroomID => _bathroomID;
  void selectBathroomTypeID(String val) {
    _bathroomID = val;
    update();
  }

  List<String> _bathroomIDs = [];
  List<String> get bathroomIDs => _bathroomIDs;

  void selectBathroomTypeIDs(String val) {
    if (_bathroomIDs.contains(val)) {
      _bathroomIDs.remove(val); // Deselect the item
    } else {
      _bathroomIDs.add(val); // Select the item
    }
    update();
  }


  int _budgetTypeMin = 0;
  int get budgetTypeMin => _budgetTypeMin;

  void selectBudgetTypeMin(int index) {
    _budgetTypeMin = index;
    update();
  }

  int _budgetTypeMax = 0;
  int get budgetTypeMax => _budgetTypeMax;

  void selectBudgetTypeMax(int index) {
    _budgetTypeMax = index;
    update();
  }

  int _sqfeetmin = 0;
  int get sqftMin => _sqfeetmin;

  void selectsqFtMin(int index) {
    _sqfeetmin = index;
    update();
  }

  int _sqfeetMax = 0;
  int get sqFitMax => _sqfeetMax;

  void selectsqFtMax(int index) {
    _sqfeetMax = index;
    update();
  }

  static final List<String> _budgetTypeList = ['1 BHK', '2 BHK', '3 BHK', '4 BHK'];
  List<String> get budgetTypeList => _budgetTypeList;

  static final List<String> _bathroomTypeList = ['1', '2', '3', '4'];
  List<String> get bathroomTypeList => _bathroomTypeList;

  int _bathroomTypeIndex = 0;
  int get bathroomTypeIndex => _bathroomTypeIndex;

  void selectBathRoomTypeIndex(int index) {
    _bathroomTypeIndex = index;
    update();
  }

  int _otherOptionIndex = 0;
  int get otherOptionIndex => _otherOptionIndex;

  void SelectOptionIndex(int index) {
    _otherOptionIndex = index;
    update();
  }

  final RxDouble startPriceValue = 0.0.obs;
  final RxDouble endPriceValue = 100000000.0.obs;

  void setPriceValue(RangeValues newValues) {
    startPriceValue.value = newValues.start;
    endPriceValue.value = newValues.end;
    update();
  }

  final NumberFormat numberFormat = NumberFormat('#,###');

// Function to format the price without unnecessary decimal places
  String formatPrice(double value) {
    // Convert to integer and then to string
    return value.toInt().toString();
  }

  // Optional: Format numbers as currency
  String formatCurrency(double value) {
    return '₹${value.toStringAsFixed(0)}'; // Formatting as integer
  }

  String ? _stateId;
  String? get stateId => _stateId;

  void setStateId(String val) {
    _stateId = val;
    update();
  }

  String ? _nearByLocationId;
  String? get nearByLocationId => _nearByLocationId;

  void setNearByLocationId(String val) {
    _nearByLocationId = val;
    update();
  }



  // String ? _propertyCategoryId;
  // String? get propertyCategoryId => _propertyCategoryId;
  //
  // void setPropertyCategoryId(String val) {
  //   _propertyCategoryId = val;
  //   update();
  // }


  // final List<String> _propertyCategoryIds = [];
  // List<String> get propertyCategoryIds => _propertyCategoryIds;
  //
  // void setPropertyCategoryIds(String val) {
  //   if (_propertyCategoryIds.contains(val)) {
  //     _propertyCategoryIds.remove(val);
  //   } else {
  //     _propertyCategoryIds.add(val);
  //   }
  //   update();
  // }
  final RxList<String> _propertyCategoryName = <String>[].obs;
  List<String> get propertyCategoryName => _propertyCategoryName.toList();

  void setPropertyCategoryName(String val) {
    if (_propertyCategoryName.contains(val)) {
      _propertyCategoryName.remove(val);
    } else {
      _propertyCategoryName.add(val);
    }
  }




  final RxList<String> _propertyCategoryIds = <String>[].obs;
  List<String> get propertyCategoryIds => _propertyCategoryIds.toList();

  void setPropertyCategoryIds(String val) {
    if (_propertyCategoryIds.contains(val)) {
      _propertyCategoryIds.remove(val);
    } else {
      _propertyCategoryIds.add(val);
    }
  }

  var selectedYear = DateTime.now().obs;
  // void updateSelectedYear(DateTime newYear) {
  //   selectedYear.value = newYear;
  // }
  String get formattedYear => "${selectedYear.value.year}";
  TextEditingController buildYearController = TextEditingController();
  TextEditingController expireYearController = TextEditingController();

  void updateSelectedYear(DateTime newYear) {
    selectedYear.value = newYear;
    buildYearController.text = "${newYear.year}";
  }

  void updateSelectedExpireYear(DateTime newYear) {
    selectedYear.value = newYear;
    expireYearController.text = "${newYear.year}";
  }


  Dialog yearPicker(String? title,{bool isBuildYear = false}) {
    DateTime lastDate = isBuildYear
        ? DateTime.now()
        : DateTime(2040, 12, 31);
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Text(title!),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year - 24, 1),
                lastDate: lastDate,
                initialDate: DateTime.now(),
                selectedDate: selectedYear.value,
                onChanged: (DateTime dateTime) {
                  if(isBuildYear) {
                    updateSelectedYear(dateTime);

                  }else {
                    updateSelectedExpireYear(dateTime);

                  }

                  print('========> Check DateTime  >>>${formattedYear}');
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  String _roomDigit = '';
  String get roomDigit => _roomDigit;
  void selectRoomDigit(String val) {
    _roomDigit = val;
    update();
  }
  String _floorDigit = '';
  String get floorDigit => _floorDigit;
  void selectFloorDigit(String val) {
    _floorDigit = val;
    update();
  }

  String _bathroomDigit = '';
  String get bathroomDigit => _bathroomDigit;
  void selectBathroomDigit(String val) {
    _bathroomDigit = val;
    update();
  }
  String _bedroomDigit = '';
  String get bedroomDigit => _bedroomDigit;
  void selectBedroomDigit(String val) {
    _bedroomDigit = val;
    update();
  }
  String _kitchenDigit = '';
  String get kitchenDigit => _kitchenDigit;
  void selectKitchenDigit(String val) {
    _kitchenDigit = val;
    update();
  }

  String _spaceDigit = '';
  String get spaceDigit => _spaceDigit;
  void selectSpaceDigit(String val) {
    _spaceDigit = val;
    update();
  }

  String _unitDigit = '';
  String get unitDigit => _unitDigit;
  void selectUnitDigit(String val) {
    _unitDigit = val;
    update();
  }

  final List<String> roomList = [
    "1",
    "2",
    "3",
    "4",
    "+5",
  ];






}
