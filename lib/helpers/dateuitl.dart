// ignore_for_file: unnecessary_new, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final class DateFormatedUtils {
  static String getFormatedDate(DateTime date, String dateFormat) {
    var now = new DateTime.now();

    var formatter = new DateFormat(dateFormat);
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  TimeOfDay formattedTnD(String time) {
    List<String> sp = time.split(':');
    int h = int.parse(sp[0]);
    int m = int.parse(sp[1]);
    return TimeOfDay(hour: h, minute: m);
  }

  DateTime formatDateTime(String data) {
    var inputFormat = DateFormat('dd-MM-yyyy'); //16-07-2022
    var inputDate = inputFormat.parse(data);

    var outputFormatY = DateFormat('yyyy');
    var outputFormatM = DateFormat('MM');
    var outputFormatD = DateFormat('dd');
    var outputDateY = int.parse(outputFormatY.format(inputDate));
    var outputDateM = int.parse(outputFormatM.format(inputDate));
    var outputDateD = int.parse(outputFormatD.format(inputDate));

    return DateTime(outputDateY, outputDateM, outputDateD);
  }

//All Date are 12 hours Format
  String date12format(String date) {
    var hour12Format = DateFormat("yyyy-MM-dd h:mm a");
    final formatedDate = hour12Format.format(DateTime.parse(date));
    return formatedDate;
  }

  static String comapareDate(String date) {
    var now = new DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    DateTime incomingDate = DateFormat("dd-MM-yyyy").parse(date);

    if (now.compareTo(incomingDate) == 0) {
      return "Hoje".tr + " - ${incomingDate.day}" "/" " ${incomingDate.month}";
    }

    if (incomingDate.difference(now).inDays == 1) {
      return "Amanha".tr + " - ${incomingDate.day}" "/" " ${incomingDate.month}";
    }
    return date;
  }
}
