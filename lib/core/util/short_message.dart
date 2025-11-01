import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/res/color/app_color.dart';
class ShortMessage{
    static void showErrorMessage(String message){
      Get.showSnackbar(
        GetSnackBar(
          title:"Alert",
          icon: Icon(Icons.error_outline),
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: DismissDirection.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
           animationDuration: Duration(seconds: 3),
          borderColor:Colors.red.shade200,
          backgroundColor:AppColor.redColor,
          message: message,
        )
      );
    }
    static void showSuccessMessage(String message){
      Get.showSnackbar(
          GetSnackBar(
            title:"Success",
            snackPosition: SnackPosition.BOTTOM,
            dismissDirection: DismissDirection.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            animationDuration: Duration(seconds: 3),
            borderColor:Colors.red.shade200,
            backgroundColor:AppColor.primaryColor,
            messageText: Text(message,style: TextStyle(color: Colors.black),),
          )
      );
    }
}