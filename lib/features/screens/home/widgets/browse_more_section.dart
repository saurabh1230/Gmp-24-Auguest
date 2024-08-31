import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class BrowseMoreSection extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Function() onTap;
  const BrowseMoreSection({super.key, required this.title, required this.description, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,
          right: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSize30),
      child: Column(
        children: [
          Image.asset(image,height: 120,),
          sizedBox8(),
          Text(title,style: senBold.copyWith(fontSize: Dimensions.fontSize18),),
          sizedBox8(),
          Text(description,style: senRegular.copyWith(fontSize: Dimensions.fontSize14,
          color: Theme.of(context).disabledColor.withOpacity(0.40)),
          textAlign: TextAlign.center,maxLines: 2,),
          sizedBoxDefault(),
          PrettyWaveButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: onTap,
            child:  Text(
              'Browse →',
              style: senBold.copyWith(
                color:  Theme.of(context).cardColor ,
                fontSize:  Dimensions.fontSize18,
              ) ,
            ),
          ),


        ],
      ),
    );
  }
}
