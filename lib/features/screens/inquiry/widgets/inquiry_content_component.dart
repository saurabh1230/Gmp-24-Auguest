import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/inquiry_controller.dart';
import 'package:get_my_properties/features/screens/home/widgets/custom_container.dart';
import 'package:get_my_properties/features/widgets/custom_image_widget.dart';
import 'package:get_my_properties/features/widgets/date_formatter.dart';
import 'package:get_my_properties/utils/app_constants.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/utils/theme/light_theme.dart';
class InquiryContentComponent extends StatelessWidget {
  final String date;
  final String time;
  final String image;
  final String propertyTitle;
  final String agentName;
  final String customerName;
  final String customerContactNo;
  final String message;
  final String propertyId;
  final String status;
  const InquiryContentComponent({super.key, required this.date, required this.image, required this.propertyTitle, required this.agentName, required this.message, required this.propertyId, required this.status, required this.customerName, required this.customerContactNo, required this.time});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InquiryController>(builder: (inquiryControl) {
      return   CustomDecoratedContainer(
        vertical: Dimensions.paddingSize10,
        color: Theme.of(context)
            .primaryColor
            .withOpacity(0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Preferred Date : ${date}'),
                    Text('Preferred Time : ${time}'),
                  ],
                ),

                Get.find<AuthController>().isCustomerLoggedIn() ?
                    const SizedBox() :
                PopupMenuButton<String>(
                  icon: Icon(
                    CupertinoIcons.eye_fill,
                    color: Theme.of(context).primaryColor,
                  ),
                  onSelected: (String value) {
                    inquiryControl.vendorInquiryReplyApi(propertyID: propertyId, status: value);
                    print('Selected menu item: $value');
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'rejected',
                        child: Text('Rejected'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'contacted',
                        child: Text('Contacted'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            sizedBox10(),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImageWidget(
                  image:
                  '${AppConstants.imgBaseUrl}$image',
                  height: 100,
                  width: 100,
                  radius: Dimensions.radius5,
                ),
                sizedBoxW10(),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(maxLines :3,overflow: TextOverflow.ellipsis,
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Property: ',
                              style: senRegular.copyWith(color: Theme.of(context).disabledColor.withOpacity(0.60),
                                  fontSize: Dimensions.fontSize14),
                            ),
                            // New line
                            TextSpan(
                                text: propertyTitle,
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
                                )
                            ),
                          ],
                        ),
                      ),
                      sizedBox10(),
                      Get.find<AuthController>().isCustomerLoggedIn() ?
                      RichText(maxLines :3,overflow: TextOverflow.ellipsis,
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Agent: ',
                              style: senRegular.copyWith(color: Theme.of(context).disabledColor.withOpacity(0.60),
                                  fontSize: Dimensions.fontSize14),
                            ),
                            // New line
                            TextSpan(
                                text: agentName,
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
                                )
                            ),
                          ],
                        ),
                      ) :
                      Column(
                        children: [
                          RichText(maxLines :3,overflow: TextOverflow.ellipsis,
                            text:  TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Customer: ',
                                  style: senRegular.copyWith(color: Theme.of(context).disabledColor.withOpacity(0.60),
                                      fontSize: Dimensions.fontSize14),
                                ),
                                // New line
                                TextSpan(
                                    text: customerName,
                                    style: senRegular.copyWith(
                                        fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
                                    )
                                ),
                              ],
                            ),
                          ),
                          sizedBox10(),
                          RichText(maxLines :3,overflow: TextOverflow.ellipsis,
                            text:  TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Contact No: ',
                                  style: senRegular.copyWith(color: Theme.of(context).disabledColor.withOpacity(0.60),
                                      fontSize: Dimensions.fontSize14),
                                ),
                                // New line
                                TextSpan(
                                    text: customerContactNo,
                                    style: senRegular.copyWith(
                                        fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      sizedBox10(),
                      RichText(maxLines :6,overflow: TextOverflow.ellipsis,
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Message: ',
                              style: senRegular.copyWith(color: Theme.of(context).disabledColor.withOpacity(0.60),
                                  fontSize: Dimensions.fontSize14),
                            ),
                            // New line
                            TextSpan(
                                text: message,
                                style: senRegular.copyWith(
                                    fontSize: Dimensions.fontSize14,color: Theme.of(context).disabledColor
                                )
                            ),
                          ],
                        ),
                      ),
                      sizedBox10(),
                      Align(alignment: Alignment.centerRight,
                        child: CustomDecoratedContainer(
                            color: status.contains('contacted') ?
                            greenColor :
                            redColor,


                            child: Text(status.toUpperCase(),style: senRegular.copyWith(
                              fontSize: Dimensions.fontSize12,
                              color: Theme.of(context).cardColor
                            ),)),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
