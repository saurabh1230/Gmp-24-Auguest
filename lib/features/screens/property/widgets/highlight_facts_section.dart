import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/properties_controller.dart';
import 'package:get_my_properties/controller/property_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
class HighlightFactsSection extends StatelessWidget {
  final String bedRoom;
  final String bathRoom;
  final String room;
  final String space;
  final String floor;
  final String kitchen;
  const HighlightFactsSection({super.key,
    required this.bedRoom,
    required this.bathRoom,
    required this.room, required this.space, required this.floor, required this.kitchen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,),
      child: GetBuilder<PropertyController>(builder: (controller) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Highlights & Facts",style:  senBold.copyWith(fontSize: Dimensions.fontSizeDefault,),),
            // sizedBox10(),
            // Text("Interior",style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).primaryColor),),
            // sizedBox10(),
            // Text("Bedrooms & bathrooms",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Bedrooms",bedRoom),
            // const Divider(),
            // buildRow(context,"Bathrooms",bathRoom),
            // const Divider(),
            // buildRow(context,"Full bathrooms","2"),
            // sizedBox20(),
            // Text("Bedroom 2",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Description","Ceiling Fan,Closet"),
            // const Divider(),
            // buildRow(context,"Dimensions","12x12"),
            // const Divider(),
            // sizedBox20(),
            // Text("Appliances",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Appliances included","Dishwasher, Gas Range,Microwave"),
            // const Divider(),
            // buildRow(context,"Laundry features","Main Level"),
            // sizedBox20(),
            // Text("Family room",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Dimensions","20 X 18"),
            // sizedBox20(),
            // Text("Family room",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Dimensions","20 X 18"),
            // sizedBox20(),
            // Text("Cooling",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Cooling features","Central Air, Electric"),
            // sizedBox20(),
            // Text("Kitchen",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Description","Pantry"),
            // const Divider(),
            // buildRow(context,"Dimensions","12x12"),
            sizedBox20(),
            Container(
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize4,horizontal:  Dimensions.paddingSizeDefault),
                color: Theme.of(context).primaryColor.withOpacity(0.10),
                child: Text("Property Detail",style: senRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),)),
            sizedBox20(),
            // Text("Property Detail",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  buildRow(context,"Total Bedroom",bedRoom),
                  const Divider(),
                  buildRow(context,"Total Bathroom",bathRoom),
                  const Divider(),
                  buildRow(context,"Total Rooms",room),
                  const Divider(),
                  buildRow(context,"Bhk",'${space}'),
                  const Divider(),
                  buildRow(context,"Total Floor",floor),
                  const Divider(),
                  buildRow(context,"Total Kitchen",kitchen),
                  const Divider(),
                  sizedBox20(),
                ],
              ),
            ),
            // Text("Lot",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Lot size","4,791 sqft"),
            // const Divider(),
            // buildRow(context,"Lot features","Desert Landscaping"),
            // sizedBox20(),
            // Text("Property",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Stories","1"),
            // const Divider(),
            // buildRow(context,"Exterior features","Patio"),
            // const Divider(),
            // buildRow(context,"Patio & porch details","Covered"),
            // const Divider(),
            // buildRow(context,"Fencing","Block,Partial"),
            // sizedBox20(),
            // Container(
            //     width: Get.size.width,
            //     padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSize4),
            //     color: Theme.of(context).primaryColor.withOpacity(0.10),
            //     child: Text("Construction",style: senRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColor),)),
            // sizedBox20(),
            // Text("Type & style",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Home type","Mobile Manufactured"),
            // const Divider(),
            // buildRow(context,"Architectural style","Building"),
            // const Divider(),
            // buildRow(context,"Property subType","Family Apartments"),
            // const Divider(),
            // sizedBox20(),
            // Text("Condition",style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor),),
            // sizedBox8(),
            // buildRow(context,"Property condition","Resale"),
            // const Divider(),
            // buildRow(context,"Year built","2024"),

            // SizedBox(
            //   height: 100,
            //   child: ListView.builder(
            //     itemCount:  controller.highLightImage.length,
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //       itemBuilder: (_,i) {
            //     return PrimaryCardContainer(
            //       color: Theme.of(context).primaryColor,
            //       child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset(controller.highLightImage[i],height: 36,),
            //           sizedBox4(),
            //           Text(controller.highLightNames[i],style: senRegular.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).primaryColor),),
            //
            //         ],
            //       ),
            //     );
            //   }),
            // )

          ],
        );
      }),

    );
  }

  Row buildRow(BuildContext context, String title, String desc) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title,style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor.withOpacity(0.50)),)),
            Expanded(child: Align(alignment: Alignment.centerRight,
              child: Text(desc,style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor.withOpacity(0.50),
              ),maxLines: 2,overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,),
            )),
          ],
        );
  }
}
