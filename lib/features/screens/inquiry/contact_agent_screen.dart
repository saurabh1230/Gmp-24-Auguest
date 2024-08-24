import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';

class ContactAgentScreen extends StatelessWidget {
   ContactAgentScreen({super.key});

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomButtonWidget(buttonText: 'Contact Agent',onPressed: () {},),
        ),
      ),
      appBar: const CustomAppBar(title: 'Contact Agent',isBackButtonExist: true,),
      body: SingleChildScrollView(
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
                const Column(
                  children: [
                    Text('Agent Name',style: senRegular,),
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
                hintText: 'Phone Number',
                inputType: TextInputType.number,
                controller:_phoneController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Contact Number';
                  }
                  return null;
                },
              ),
              sizedBox10(),
              





            ],
          ),
        ),
      ),

    );
  }
}
