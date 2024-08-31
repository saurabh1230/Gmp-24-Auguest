import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/filter_bottom_sheet.dart';
import 'package:get_my_properties/features/screens/property/sale_and_rent_dashboard/sale_and_rent_property_section.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';

class SaleAndRentDashboard extends StatefulWidget {
  final int pageIndex;
  final String? type;
  final String? typeId;
  final String? purposeId;
  const SaleAndRentDashboard({Key? key, required this.pageIndex, required this.type, this.typeId, this.purposeId}) : super(key: key);

  @override
  _SaleAndRentDashboardState createState() => _SaleAndRentDashboardState();
}

class _SaleAndRentDashboardState extends State<SaleAndRentDashboard> {
  late PageController _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    print(widget.purposeId);
    super.initState();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);
    _screens = [
      SaleAndRentPropertySection(type: widget.type!,typeId: widget.typeId!,purposeId: widget.purposeId! ,),
      SaleAndRentPropertySection(type: widget.type!,typeId: widget.typeId!,purposeId: widget.purposeId!),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        Get.find<PropertyController>().getPropertyList(page: '1');
        return true; // Allow the pop action to proceed
      },
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          toolbarHeight: 80,
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize8, horizontal: Dimensions.paddingSize8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              color: Theme.of(context).cardColor,
            ),
            margin: const EdgeInsets.only(top: Dimensions.paddingSize40, left: Dimensions.paddingSize40, right: Dimensions.paddingSize40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.find<PropertyController>().getPropertyList(page: '1',);
                      },
                    child: Container(
                        padding: const EdgeInsets.all(Dimensions.paddingSize4),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,),
                        child: Icon(Icons.arrow_back,color: Theme.of(context).cardColor,))),
                sizedBoxW10(),
                sizedBoxW5(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _setPage(0);
                      Get.find<PropertyController>().getPropertyList(page: '1',
                          purposeId: widget.purposeId,
                          typeId:widget.typeId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _pageIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize20),
                      child: Center(
                        child: Text(
                          "Buy",
                          style: TextStyle(
                            color: _pageIndex == 0 ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _setPage(1);
                      // Get.find<PropertyController>().getPropertyList(page: '1',
                      //     purposeId: widget.purposeId,
                      //     typeId:widget.typeId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _pageIndex == 1 ? Theme.of(context).primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize20),
                      child: Center(
                        child: Text(
                          "Rent",
                          style: TextStyle(
                            color: _pageIndex == 1 ? Theme.of(context).cardColor : Theme.of(context).disabledColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      title: 'Location',
                      tap: () {},
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: CustomOutlineButton(
                      title: 'Filters',
                      filter: true,
                      filterText: "  (2)",
                      tap: () {
                        Get.bottomSheet(
                          const FilterBottomSheet(),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(child: CustomButtonWidget(
                    height: 35,
                    radius: Dimensions.radius5,
                    isBold: false,
                    buttonText: "X Clear Filter",
                    onPressed: () {
                      Get.find<PropertyController>().getPropertyList(page: '1',
                      );
                    },
                    fontSize:  Dimensions.fontSize12,))
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _screens.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _screens[index];
                },
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );

  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
