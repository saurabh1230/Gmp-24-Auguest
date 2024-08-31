import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_app_button.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';
import 'dart:math';

import 'package:get_my_properties/utils/styles.dart';
class EmiCalculator extends StatefulWidget {
  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  double loanAmount = 50000;
  int loanTenure = 12;
  double interestRate = 14; // Annual interest rate

  double get emi {
    double monthlyInterestRate = interestRate / 12 / 100;
    double emi = loanAmount * monthlyInterestRate *
        pow(1 + monthlyInterestRate, loanTenure) /
        (pow(1 + monthlyInterestRate, loanTenure) - 1);
    return emi;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault,horizontal: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Calculate EMI",style:  senBold.copyWith(fontSize: Dimensions.fontSizeDefault,),),
          sizedBox10(),

          Text('Down Payment: ₹${loanAmount.toStringAsFixed(0)}'),
          Slider(
            min: 10000,
            max: 1000000,
            divisions: 100,
            value: loanAmount,
            onChanged: (value) {
              setState(() {
                loanAmount = value;
              });
            },
          ),
          Text('Tenure: $loanTenure months'),
          Slider(
            min: 6,
            max: 360,
            divisions: 60,
            value: loanTenure.toDouble(),
            onChanged: (value) {
              setState(() {
                loanTenure = value.toInt();
              });
            },
          ),
          // sizedBox10(),
          Row(children: [
            const Expanded(child: Divider()),
            Expanded(child: Center(child: Text("Estimated EMI",style: senRegular.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.40)),))),
            const Expanded(child: Divider()),

          ],),
          sizedBox10(),
          Center(
            child: Text(
              '₹ ${emi.toStringAsFixed(2)}/month',
              style:senBold.copyWith(fontSize: Dimensions.fontSize24,color: Theme.of(context).disabledColor),
            ),
          ),
          Center(child: Text("For $loanTenure months @ $interestRate%",style: senRegular.copyWith(fontSize: Dimensions.fontSize12,color: Theme.of(context).disabledColor.withOpacity(0.40)),)),
          sizedBoxDefault(),
          CustomButtonWidget(buttonText: "Connect For Loan",onPressed: () {},)
        ],
      ),
    );
  }
}
