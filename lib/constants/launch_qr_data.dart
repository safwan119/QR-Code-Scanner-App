import 'package:flutter/material.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/url/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchQrData {
  static Future<void> launchQrData(BuildContext context, String qrData) async {
    Uri? uri;
    try {
      uri = Uri.parse(qrData);
    } on FormatException {
      ShortMessage.showErrorMessage(context, 'This is a text.Use Copy button.');
      return;
    } catch (e) {
      ShortMessage.showErrorMessage(context, "Error:$e");
      return;
    }
    if (qrData.startsWith('http://') ||
        qrData.startsWith('https://') ||
        qrData.startsWith(AppUrls.locationLaunchUrl)) {
      final urlString = qrData.startsWith('http') ? qrData : 'https://$qrData';
      final uri = Uri.parse(urlString.trim());
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (qrData.startsWith('http://wa.me/') ||
        qrData.startsWith("tel") ||
        qrData.startsWith("mailto")) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ShortMessage.showErrorMessage(
          context,
          "Not a recognized link/number. Please use Copy button.",
        );
      }
    }
  }
}
