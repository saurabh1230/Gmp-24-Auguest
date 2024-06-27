import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class RecommendedItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final Function() tap;
  const RecommendedItemCard({super.key, required this.image, required this.title, required this.description, required this.price, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 126,width: 220,
            child: Image.asset(image),
          ),
          sizedBox8(),
          Text(title,style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault,),maxLines: 1,overflow: TextOverflow.ellipsis,),
          Text(description,style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor.withOpacity(0.50)),
            maxLines: 2,overflow: TextOverflow.ellipsis,),
          sizedBox8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(price,style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).hintColor),)),
              Expanded(
                child: CheckoutArrowButton(tap: tap,),
              )
            ],)
        ],
      ),
    );
  }
}
