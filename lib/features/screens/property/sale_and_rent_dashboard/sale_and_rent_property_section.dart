import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/explore/explore_screen.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/custom_button.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class SaleAndRentPropertySection extends StatelessWidget {
  final String type;
  final String typeId;
  final String purposeId;
  const SaleAndRentPropertySection({super.key, required this.type, required this.typeId, required this.purposeId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('=====================> purposeId Id  ${purposeId}');
      print('=====================> typeId Id  ${typeId}');
      Get.find<PropertyController>().getPropertyList(page: '1',
      purposeId: purposeId,
      typeId:typeId);
    });
    return GetBuilder<PropertyController>(builder: (propertyControl) {
      final list = propertyControl.propertyList;
      final isListEmpty = list == null || list.isEmpty;
      final isLoading = propertyControl.isPropertyLoading;
      return isListEmpty && !isLoading
          ? Center(
              child: EmptyDataWidget(
                image: Images.emptyDataImage,
                fontColor: Theme.of(context).disabledColor,
                text: 'No $type Properties yet',
              )) :
        isLoading ? const ExploreScreenShimmer() :
        Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Looking for $type (${list!.length})',style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
            sizedBox12(),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (_,i) {
                  return RecommendedItemCard(
                    vertical: true,
                    image: list[i].displayImages[0].image,
                    title:  list[i].title.toString(),
                    description:  list[i].description.toString(),
                    price: '${list[i].price}',
                    propertyId: list[i].id.toString(),
                    markerPrice:  list[i].marketPrice.toString(),
                    );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimensions.paddingSizeDefault,),),
            )
          ],),
      );
    });


  }
}
