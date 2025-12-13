import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortMessage {
  static void showErrorMessage(String message) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Alert",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        // icon: Icon(Icons.error_outline,color:AppColors.backgroundColor,),
        snackPosition: SnackPosition.BOTTOM,
        dismissDirection: DismissDirection.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        borderRadius: 16.0,
        animationDuration: Duration(seconds: 3),
        borderColor: const Color(0xFFC6414C),
        backgroundColor: Colors.red,
        messageText: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  static void showSuccessMessage(String message) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Success",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 16.0,
        dismissDirection: DismissDirection.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        animationDuration: Duration(seconds: 2),
        borderColor: const Color(0xFF86C641),
        backgroundColor: Colors.green,
        messageText: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
