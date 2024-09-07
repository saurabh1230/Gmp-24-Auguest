import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/recommended_item_card.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class BrowseOtherConstructionsSection extends StatelessWidget {
  const BrowseOtherConstructionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<PropertyController>().getPropertyList(page: '1');
    });
    return GetBuilder<PropertyController>(builder: (propertyControl) {
      final list = propertyControl.propertyList;
      final isListEmpty = list == null || list.isEmpty;
      final isLoading = propertyControl.isPropertyLoading;
      return isListEmpty && !isLoading
          ? Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSize100),
        child: Center(
            child: EmptyDataWidget(
              image: Images.emptyDataImage,
              fontColor: Theme.of(context).disabledColor,
              text: 'No Recommended Properties yet',
            )),
      )
          : Padding(
        padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault, bottom:Dimensions.paddingSizeDefault, left:Dimensions.paddingSizeDefault, ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Browse Other Constructions",style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
            sizedBox12(),
            SizedBox(
              height: Get.size.height * 0.30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: list!.length,
                itemBuilder: (_,i) {
                  return RecommendedItemCard(
                    image: list[i].displayImages[0].image,
                    title: list[i].title.toString(),
                    description: list[i].description.toString(),
                    price: list[i].price.toString(),
                    propertyId: list[i].id.toString(),
                    markerPrice:  list[i].marketPrice.toString(),
                  );
                }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: Dimensions.paddingSizeDefault,),),
            )
          ],),
      );
    });



  }
}
