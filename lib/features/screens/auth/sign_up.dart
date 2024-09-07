import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/features/screens/Maps/location_view.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_buttons.dart';
import 'package:get_my_properties/features/widgets/custom_textfield.dart';
import 'package:get_my_properties/features/widgets/date_formatter.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (authControl) {
        return Form(
          key:_formKey,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.authBgImage),
                    fit: BoxFit.contain,
                    alignment:
                        Alignment.topCenter,
                  ),
                ),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sizedBox100(),
                          sizedBox100(),
                          Text("Login / Register",
                              style: senExtraBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSize32)),
                          sizedBoxDefault(),
                          Text(
                            "Enter Your Phone Number",
                            style: senBold.copyWith(
                                color:
                                    Theme.of(context).disabledColor.withOpacity(0.60),
                                fontSize: Dimensions.fontSize15),
                          ),
                          sizedBox4(),
                          Text(
                            "You'll get a verification code from us.",
                            style: senRegular.copyWith(
                                color:
                                    Theme.of(context).disabledColor.withOpacity(0.40),
                                fontSize: Dimensions.fontSize13),
                          ),
                          sizedBox12(),
                          CustomTextField(
                            isNumber: true,
                            inputType: TextInputType.number,
                            controller: _phoneController,
                            isPhone: true,
                            hintText: "Enter your mobile number here",
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Phone No';
                              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit Phone No';
                              }
                              return null;
                            },

                          ),


                          sizedBox20(),
                          Center(
                              child: Text(
                            "Login As",
                            style: senBold.copyWith(
                                color:
                                    Theme.of(context).disabledColor.withOpacity(0.60),
                                fontSize: Dimensions.fontSize15),
                          )),
                          sizedBoxDefault(),
                          Center(
                            child: Wrap(
                              spacing: 8.0, // Space between chips
                              runSpacing: 8.0, // Space between lines of chips
                              children: List.generate(
                                authControl.loginTypeList.length,
                                (index) {
                                  return CustomSelectedButton(
                                    tap: () {
                                      authControl.selectLoginType(index);
                                      print(authControl.loginType);
                                    },
                                    title: capitalizeFirstLetter(authControl.loginTypeList[index]),
                                    isSelected: authControl.loginType == index,
                                  );
                                },
                              ),
                            ),
                          ),

                          // TextButton(onPressed: () {
                          //   Get.toNamed(RouteHelper.getLocationPickerRoute());
                          // }, child: Text('child'))

                        ],
                      ),
                    )),
              ),
              Positioned(
                bottom: Dimensions.paddingSizeDefault,
                left: Dimensions.paddingSizeDefault,
                right: Dimensions.paddingSizeDefault,
                child: authControl.isLoginLoading ?
                    const Center(child: CircularProgressIndicator()) :
                CustomButtonWidget(
                  buttonText: "Continue",
                  onPressed: () {
                    bool isVendor = authControl.loginType == 1;
                    if(_formKey.currentState!.validate()) {
                      authControl.userLoginApi(_phoneController.text,isVendor: isVendor);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
