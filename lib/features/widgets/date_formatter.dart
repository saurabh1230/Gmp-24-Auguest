
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateFormatter {
  static String convertDateToDate(String date) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(date));
  }



}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}