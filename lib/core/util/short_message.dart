import 'package:another_flushbar/flushbar_route.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ShortMessage {
  static void showErrorMessage(BuildContext context, String message) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        title: "Alert",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        borderColor: Colors.red.shade400,
        borderRadius: BorderRadius.circular(16),
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        message: message,
        titleColor: Colors.white,
        safeArea: true,
        messageColor: Colors.white,
        messageSize: 16,
        titleSize: 18,
        margin: EdgeInsets.symmetric(horizontal: 20),
        reverseAnimationCurve: Curves.bounceIn,
      )..show(context),
    );
  }
  static void showSuccessMessage(BuildContext context, String message) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        title: "Success",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        borderColor: Colors.green.shade400,
        borderRadius: BorderRadius.circular(16),
        flushbarPosition: FlushbarPosition.TOP,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        message: message,
        titleColor: Colors.white,
        safeArea: true,
        messageColor: Colors.white,
        messageSize: 18,
        titleSize: 18,
        margin: EdgeInsets.symmetric(horizontal: 20),
      )..show(context),
    );
  }
}
