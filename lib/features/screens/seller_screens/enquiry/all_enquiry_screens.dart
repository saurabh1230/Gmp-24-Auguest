import 'package:flutter/material.dart';
import 'package:get_my_properties/controller/vendor_controller.dart';
import 'package:get_my_properties/data/models/response/admin_dashboard_model.dart';
import 'package:get_my_properties/features/screens/dashboard/widgets/inquiry_request_section.dart';
import 'package:get_my_properties/features/screens/seller_screens/enquiry/components/enquiry_section_component.dart';
import 'package:get_my_properties/features/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:get_my_properties/features/widgets/empty_data_widget.dart';
import 'package:get_my_properties/utils/date_converter.dart';
import 'package:get_my_properties/utils/dimensions.dart';
import 'package:get_my_properties/utils/images.dart';
import 'package:get_my_properties/utils/sizeboxes.dart';



class AllEnquiryScreens extends StatefulWidget {
  const AllEnquiryScreens({super.key,});

  @override
  State<AllEnquiryScreens> createState() => _AllEnquiryScreensState();
}

class _AllEnquiryScreensState extends State<AllEnquiryScreens> {


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<VendorController>().getAllEnquiryList(page: '1');
    });
    return Scaffold(
      appBar: const CustomAppBar(title: 'All Enquiry',isBackButtonExist: true,),
      body: GetBuilder<VendorController>(builder: (vendorControl) {
        final list = vendorControl.enquiryList;
        final isListEmpty = list == null || list.isEmpty;
        final isLoading = vendorControl.isLoading;

        return   isListEmpty && !isLoading
            ? Center(
            child: EmptyDataWidget(
              image: Images.emptyDataImage,
              fontColor: Theme.of(context).primaryColor,
              text: 'No Enquiries yet',
            )) :

          SingleChildScrollView(
          child: Column(
            children: [
              isLoading ?
              const InquiryRequestShimmer() :
              ListView.separated(
                padding: const EdgeInsets.all(Dimensions.fontSizeDefault),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list!.length,
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  final inquiry = list[i];
                  final DateTime createdAtDate = DateConverter.parseDateString(inquiry.date);
                  final formattedDate = DateConverter.estimatedOnlyDate(createdAtDate);
                  return EnquirySectionComponent(
                    name: inquiry.name,
                    formattedDate: formattedDate,
                    email: inquiry.email,
                    phone: inquiry.phoneNumber.toString(),);
                },
                separatorBuilder: (BuildContext context, int index) => sizedBoxDefault(),
              ),
            ],
          ),
        );
      })
    );
  }
}
