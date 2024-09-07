import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_see_more_widget.dart';
import 'package:get_my_properties/features/widgets/prefix_icon_text_holder.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class PropertyDetailsSection extends StatelessWidget {
  final String address;
  final String price;
  final String propertyType;
  final String beds;
  final String bath;
  final String sqFt;
  final String propertyTitle;
  final String propertyDesc;
  final String floors;
  final String HOA;
  final String city;

  const PropertyDetailsSection({super.key, required this.address, required this.price, required this.propertyType, required this.beds, required this.bath, required this.sqFt, required this.propertyTitle, required this.floors, required this.HOA, required this.city, required this.propertyDesc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_sharp,
              size: Dimensions.fontSizeDefault,
              color: Theme.of(context).disabledColor.withOpacity(0.40),
            ),
            Expanded(
              child: Text(
                address,
                style: senRegular.copyWith(
                    fontSize: Dimensions.fontSize12,
                    color: Theme.of(context)
                        .disabledColor
                        .withOpacity(0.40)), maxLines: 3,
              ),
            )
          ],
        ),
        sizedBox12(),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "${price}",
                    style: senRegular.copyWith(fontSize: Dimensions.fontSize24),
                  ),
                ),
                // sizedBoxW30(),
                // Expanded(
                //     child: PrefixIconTextHolder(img: Images.appartmentImage, text: propertyType,)
                // )
              ],
            ),
            sizedBox10(),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildRichText(context,beds," Beds"),
                sizedBoxW15(),
                buildRichText(context,bath," Baths"),
                sizedBoxW15(),
                buildRichText(context,sqFt," SqFt"),
              ],
            ),
            sizedBox10(),
            Text(propertyTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: senBold.copyWith(fontSize: Dimensions.fontSizeDefault,)),
            sizedBox10(),
             SeeMoreText(
               maxLines: 3,
              text: propertyDesc,
            ),
            sizedBox10(),
            Row(
              children: [
                Expanded(
                    child: PrefixIconTextHolder(
                      backgroundColor:  Theme.of(context).disabledColor.withOpacity(0.04),
                      iconColor: Theme.of(context).disabledColor.withOpacity(0.50),
                      textColor:  Theme.of(context).disabledColor.withOpacity(0.50),
                      img: Images.icAppartmentImageLight, text: propertyType,)
                ),
                sizedBoxW10(),
                Expanded(
                    child: PrefixIconTextHolder(
                      backgroundColor:  Theme.of(context).disabledColor.withOpacity(0.04),
                      iconColor: Theme.of(context).disabledColor.withOpacity(0.50),
                      textColor:  Theme.of(context).disabledColor.withOpacity(0.50),
                      img: Images.icBuildingLight, text: 'Floors: ${floors}',)
                )
              ],
            ),
            sizedBox10(),
            Row(
              children: [
                Expanded(
                    child: PrefixIconTextHolder(
                      backgroundColor:  Theme.of(context).disabledColor.withOpacity(0.04),
                      iconColor: Theme.of(context).disabledColor.withOpacity(0.50),
                      textColor:  Theme.of(context).disabledColor.withOpacity(0.50),
                      img: Images.icHandHomeLight, text: '₹${HOA} HOA',)
                ),
                sizedBoxW10(),
                Expanded(
                    child: PrefixIconTextHolder(
                      backgroundColor:  Theme.of(context).disabledColor.withOpacity(0.04),
                      iconColor: Theme.of(context).disabledColor.withOpacity(0.50),
                      textColor:  Theme.of(context).disabledColor.withOpacity(0.50),
                      img: Images.icCentralCityLight, text: '${city}',)
                )
              ],
            ),

          ],
        ),
      ],),
    );
  }

  RichText buildRichText(BuildContext context,String beds,String type) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: beds,
            style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).disabledColor),
          ),
          TextSpan(
            text: type,
            style: senRegular.copyWith(fontSize: Dimensions.fontSize15,color: Theme.of(context).disabledColor.withOpacity(0.50)),
          ),
        ],
      ),
    );
  }
}


