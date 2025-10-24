import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class LaunchQrData{
  static Future<void> launchQrData(BuildContext context,String qrData) async {
    Uri? uri;
    try {
      uri = Uri.parse(qrData);
    } on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.red,
            content: Text('This is a text.Use Copy button.')),
      );
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred: $e')),
      );
      return;
    }
    if (qrData.startsWith('http://')||qrData.startsWith('https://') || qrData.startsWith('http://googleusercontent.com/maps.google.com/7')) {
      final urlString = qrData.startsWith('http') ? qrData : 'https://$qrData';
      final uri = Uri.parse(urlString.trim());
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    else if (qrData.startsWith('http://wa.me/') || qrData.startsWith("tel") || qrData.startsWith("mailto")) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
    else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.red,
              content: Text('Not a recognized link/number. Please use Copy button.')),
        );
      }
    }
  }
}