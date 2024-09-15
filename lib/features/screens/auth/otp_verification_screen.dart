import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/auth_controller.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/features/widgets/custom_snackbar.dart';
import 'package:get_my_properties/helper/route_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'package:get_my_properties/utils/styles.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? phoneNo;

  OtpVerificationScreen({super.key, required this.phoneNo});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _remainingTime = 60;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_isResendEnabled) {
      Get.find<AuthController>().userLoginApi(widget.phoneNo.toString());
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.authBgImage),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sizedBox100(),
                      sizedBox100(),
                      Text(
                        "OTP Verification",
                        style: senExtraBold.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSize32,
                        ),
                      ),
                      sizedBoxDefault(),
                      Text(
                        "Enter OTP",
                        style: senBold.copyWith(
                          color: Theme.of(context).disabledColor.withOpacity(0.60),
                          fontSize: Dimensions.fontSize15,
                        ),
                      ),
                      sizedBox4(),
                      Text(
                        "We have sent a verification code to your number",
                        style: senRegular.copyWith(
                          color: Theme.of(context).disabledColor.withOpacity(0.40),
                          fontSize: Dimensions.fontSize13,
                        ),
                      ),
                      sizedBox20(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize25),
                        child: PinCodeTextField(
                          length: 4,
                          appContext: context,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.slide,
                          controller: _otpController,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 50,
                            fieldWidth: 50,
                            borderWidth: 1,
                            activeBorderWidth: 1,
                            inactiveBorderWidth: 1,
                            errorBorderWidth: 1,
                            selectedBorderWidth: 1,
                            borderRadius: BorderRadius.circular(Dimensions.radius10),
                            selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            inactiveColor: Theme.of(context).primaryColor,
                            activeColor: Theme.of(context).primaryColor,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          validator: (value) {
                            if (_otpController.text.length != 4) {
                              return 'Please enter a valid 4-digit OTP';
                            }
                            return null;
                          },
                          beforeTextPaste: (text) => true,
                        ),
                      ),
                      TextButton(
                        onPressed: _isResendEnabled ? _resendOtp : null,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "If you didn’t receive a code. ",
                                style: senRegular.copyWith(
                                  fontSize: Dimensions.fontSize12,
                                  color: Theme.of(context).disabledColor.withOpacity(0.40),
                                ),
                              ),
                              TextSpan(
                                text: _isResendEnabled
                                    ? "Resend"
                                    : "Resend in $_remainingTime seconds",
                                style: senBold.copyWith(
                                  fontSize: Dimensions.fontSize12,
                                  color: _isResendEnabled
                                      ? Theme.of(context).hintColor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Dimensions.paddingSizeDefault,
              left: Dimensions.paddingSizeDefault,
              right: Dimensions.paddingSizeDefault,
              child: GetBuilder<AuthController>(builder: (authControl) {
                return authControl.isLoginLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButtonWidget(
                  buttonText: "Continue",
                  onPressed: () {
                    bool isVendor = authControl.loginType == 1;
                    if (_formKey.currentState!.validate()) {
                      authControl.userOtpApi(widget.phoneNo!, _otpController.text,isVendor: isVendor);
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
