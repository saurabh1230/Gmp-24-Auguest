
import 'package:flutter/material.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class EmptyDataWidget extends StatelessWidget {
  final String image;
  final Color? fontColor;
  final String text;
  const EmptyDataWidget({super.key,required this.image, this.fontColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image,height: 120,),
        sizedBox10(),
        Text(text,
          textAlign: TextAlign.center,
          style: senRegular.copyWith(fontSize: Dimensions.fontSize14,color:fontColor?? Theme.of(context).disabledColor),)
      ],
    );
  }
}
