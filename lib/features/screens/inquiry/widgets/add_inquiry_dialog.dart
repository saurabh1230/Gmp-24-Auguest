import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/inquiry_controller.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get_my_properties/utils/theme/light_theme.dart';
import 'package:get/get.dart';


class AddInquiryDialog extends StatelessWidget {
  final String propertyId;
   AddInquiryDialog({super.key, required this.propertyId,});

   final _nameController = TextEditingController();
  final _messageController = TextEditingController();
   final _emailController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: SingleChildScrollView(
        child: GetBuilder<InquiryController>(builder: (inquiryControl) {
          return  Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radius10)
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child:  Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Inquiry',style: senBold,),
                  sizedBox10(),
                  CustomTextField(
                    hintText: 'Contact Person Name',
                    capitalization: TextCapitalization.words,
                    controller:_nameController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      } else if (RegExp(r'[^\p{L}\s]', unicode: true).hasMatch(value)) {
                        return 'Full name must not contain special characters';
                      }
                      return null;
                    },
                  ),
                  sizedBox10(),
                  CustomTextField(
                    hintText: 'Email',
                    controller:_emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  sizedBox10(),
                  CustomTextField(
                    hintText: 'Add Inquiry Message ....',
                    maxLines: 6,
                    controller:_messageController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  sizedBox10(),
                  inquiryControl.isLoading ?
                  const Center(child: CircularProgressIndicator()) :
                  Row(
                    children: [
                      sizedBoxW10(),
                      Expanded(
                        child: CustomButtonWidget(buttonText: 'Cancel',
                          height: 40,
                          borderSideColor: redColor,
                          isBold: false, fontSize: Dimensions.fontSize12,
                          color: redColor,
                          onPressed: () {
                          Get.back();
                          },),
                      ),
                      sizedBoxW10(),
                      Expanded(
                        child: CustomButtonWidget(buttonText: 'Send Inquiry',
                          height: 40,
                          isBold: false,
                          fontSize: Dimensions.fontSize12,
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              inquiryControl.userPropertyInquiryApi(
                                  propertyID: propertyId,
                                  name: _nameController.text,
                                  phoneNo:  Get.find<AuthController>().profileData!.phoneNumber.toString(),
                                  email:  _emailController.text,
                                  message:   _messageController.text, date: '', time: '',);

                            }
                          },
                        ),
                      ),
                      sizedBoxW10(),
                    ],
                  )


                ],
              ),
            ),
          );
        })


      ),
    );
  }
}
