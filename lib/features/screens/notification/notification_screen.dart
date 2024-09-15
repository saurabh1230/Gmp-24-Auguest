import 'package:flutter/material.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/images.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Notifications",isBackButtonExist: true,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EmptyDataWidget(image: Images.icEmptyPropertyPlaceHolder, text: 'No Notifications Yet')

            ],
          ),
        ),
      ),
    );
  }
}
