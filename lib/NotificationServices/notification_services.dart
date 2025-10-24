import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/Keys/one_signal_keys.dart';
import 'package:qr_code_scanner/Message/flutter_toast_message.dart';

class NotificationServices {
  String url = "https://onesignal.com/api/v1/notifications";

  sendNotification(String title, String description) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "key ${OneSignalKeys.oneSignalRestApiKey}",
          "Content-Type": " application/json",
        },
        body: jsonEncode({
          "app_id": OneSignalKeys.oneSignalKey,
          "contents": {"en": description},
          "headings": {"en": title},
          "included_segments":["Total Subscriptions"],
          "small_icon": "@mipmap/qr_code_icon",
          "android_channel_id": "278123b7-4cd3-48fe-9ac7-021d8e93de38",
        }),
      ).then((value){
        FlutterToastMessage().toastMessage("Message Sent Successfully");
      }).onError((error,stackTrace){
        FlutterToastMessage().toastMessage("Server issue:$e");
      });

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(
            "The message sent successfully and the message is ${response.body}",
          );
        }
      } else {
        if (kDebugMode) {
          print(
            "The message sent failed and the exception is ${response.statusCode} and the message is ${response.statusCode}",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("The exception in this is:$e");
      }
    }
  }
}
