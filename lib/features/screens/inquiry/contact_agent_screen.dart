import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/controller/inquiry_controller.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';
class ContactAgentScreen extends StatelessWidget {
  final String? propertyId;
  final String? agentName;
   ContactAgentScreen({super.key, required this.propertyId, this.agentName});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
   final _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: const CustomAppBar(title: 'Contact Agent',isBackButtonExist: true,),
      body: GetBuilder<InquiryController>(builder: (inquiryControl) {
        return   Form(key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: Get.size.height,
                  child: Padding(
                    padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text('Please Provide your Details to Contact with Agent',style: senRegular.copyWith(
                                  fontSize: Dimensions.fontSize14
                              ),),
                            ),
                            Image.asset(Images.icEdit,height:Dimensions.fontSize40,)

                          ],
                        ),
                        sizedBoxDefault(),
                        Row(children: [
                          Image.asset(Images.icAgentProfile,height:Dimensions.fontSize40,),
                          sizedBoxW10(),
                           Column(
                            children: [
                              Text(agentName!,style: senRegular,),
                            ],
                          )
                        ],),
                        sizedBoxDefault(),
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
                          isPhone: true,
                          isNumber: true,
                          hintText: 'Phone Number',
                          inputType: TextInputType.phone, // Use phone type for better input support
                          controller: _phoneController,
                          validation: (value) {
                            // Check if the value is empty
                            if (value == null || value.isEmpty) {
                              return 'Enter Contact Number';
                            }
                            // Check if the value contains only digits
                            if (!RegExp(r'^\d+$').hasMatch(value)) {
                              return 'Enter a valid phone number';
                            }
                            // Check if the length is exactly 10 digits
                            if (value.length != 10) {
                              return 'Phone number must be 10 digits';
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

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(bottom: Dimensions.paddingSizeDefault,
                left:  Dimensions.paddingSizeDefault,right:  Dimensions.paddingSizeDefault,
                child: inquiryControl.isLoading ?
                const Center(child: CircularProgressIndicator()) :
                CustomButtonWidget(buttonText: 'Contact Agent',onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    inquiryControl.userPropertyInquiryApi(
                      propertyID: propertyId!,
                      name: _nameController.text,
                      phoneNo:  Get.find<AuthController>().profileData!.phoneNumber.toString(),
                      email:  _emailController.text,
                      message:   _messageController.text,);
                  }
                },),
              )
            ],
          ),
        );
      })
    );
  }
}
