import 'package:flutter/material.dart';

class Utils {
  static double totalHeight({BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  static double totalWidth({BuildContext context}) {
    return MediaQuery.of(context).size.width;
  }
}
