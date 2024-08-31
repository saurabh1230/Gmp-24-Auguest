import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/images.dart';

class PaylogScreen extends StatelessWidget {
  const PaylogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Paylog'),
      body: Center(
        child: EmptyDataWidget(image: Images.emptyDataImage, text: 'No Payments Received Yet'),
      ),
    );
  }
}
