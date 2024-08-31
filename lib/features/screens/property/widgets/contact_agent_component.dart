import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class ContactAgentComponent extends StatelessWidget {
  final Function() tap;
  const ContactAgentComponent({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: InkWell(
        onTap: tap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seller you may Contact',style: senBold.copyWith(fontSize: Dimensions.fontSize24,),),
            sizedBox10(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  Image.asset(Images.icAgentProfile,height:Dimensions.fontSize40,),
                  sizedBoxW10(),
                  const Column(
                    children: [
                      Text('Contact Agent',style: senRegular,),
                    ],
                  ),
                ],
              ),
              Icon(CupertinoIcons.phone_solid,color: Theme.of(context).primaryColor,
              size: Dimensions.fontSize24,)

            ],),
          ],
        ),
      ),
    );
  }
}
