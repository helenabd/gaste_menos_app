import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static double totalHeight({BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  static double totalWidth({BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }

  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '${formatted}h';
  }

  static String date(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }
}
