import 'package:flutter/material.dart';

class AppSize {
  static late MediaQueryData? _mediaQuery;

  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
  }
  ///get height using this function
  static double getHeight(double percentage) {
    if (_mediaQuery == null) {
      throw Exception("AppSize.init(context) not called");
    }
    return _mediaQuery!.size.height * (percentage / 100);
  }
  ///get screen width using this function
  static double getWidth(double percentage) {
    if (_mediaQuery == null) {
      throw Exception("AppSize.init(context) not called");
    }
    return _mediaQuery!.size.width * (percentage / 100);
  }
  ///get height according to screen as count wise

  static double get h0_5 => getHeight(0.5);

  static double get h1 => getHeight(1.0);

  static double get h2 => getHeight(2.0);

  static double get h3 => getHeight(3.0);

  static double get h4 => getHeight(4.0);

  static double get h5 => getHeight(5.0);

  static double get h6 => getHeight(6.0);

  static double get h7 => getHeight(7.0);

  static double get h8 => getHeight(8.0);

  static double get h9 => getHeight(9.0);

  static double get h10 => getHeight(10.0);
  ///get width according to screen as count wise

  static double get w0_5 => getWidth(0.5);

  static double get w1 => getWidth(1.0);

  static double get w2 => getWidth(2.0);

  static double get w3 => getWidth(3.0);

  static double get w4 => getWidth(4.0);

  static double get w5 => getWidth(5.0);

  static double get w6 => getWidth(6.0);

  static double get w7 => getWidth(7.0);

  static double get w8 => getWidth(8.0);

  static double get w9 => getWidth(9.0);

  static double get w10 => getWidth(10.0);
}
