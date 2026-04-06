import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/Keys/one_signal_keys.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';

class NotificationServices {
  String url = "https://onesignal.com/api/v1/notifications";

  sendNotification(
    String title,
    String description,
    BuildContext context,
  ) async {
    try {
      final channelId = '278123b7-4cd3-48fe-9ac7-021d8e93de38';
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              "Authorization": "key ${OneSignalKeys.oneSignalRestApiKey}",
              "Content-Type": " application/json",
            },
            body: jsonEncode({
              "app_id": OneSignalKeys.oneSignalKey,
              "contents": {"en": description},
              "headings": {"en": title},
              "included_segments": ["Total Subscriptions"],
              "small_icon": "@mipmap/qr_code_icon",
              "android_channel_id": channelId,
            }),
          )
          .then((value) {
            ShortMessage.showSuccessMessage(
              context,
              "Message Sent Successfully",
            );
          })
          .onError((error, stackTrace) {
            ShortMessage.showErrorMessage(context, "Error:$error");
            debugPrint(
              "The error found during sending notification==>$error and stack trace==>$stackTrace",
            );
          });

      if (response.statusCode == 200) {
        debugPrint(
          "The message sent successfully and the message is ${response.body}",
        );
      } else {
        debugPrint(
          "The message sent failed and the exception is ${response.statusCode} and the message is ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("The exception in this is:$e");
    }
  }
}
