import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/constants/public_data.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:share_plus/share_plus.dart';

class SharedApkAndQrData {
  static Future<void> shareApkFile(BuildContext context) async {
    String fileName = 'app-debug.apk';
    final tempDir = await getTemporaryDirectory();
    final ByteData data = await rootBundle.load("assets/files/app-debug.apk");
    final List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    final fileToShare = File('${tempDir.path}/$fileName');
    try {
      final xFile = XFile(fileToShare.path);
      await fileToShare.writeAsBytes(bytes, flush: true);
      await SharePlus.instance.share(
        ShareParams(files: [xFile], text: 'Here is the APK of my Flutter app.'),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error sharing APK. File might be missing in assets: $e',
          ),
        ),
      );
    }
  }
  static String? shareQrDataAsText(String qrData) {
    SharePlus.instance.share(
      ShareParams(text: 'Qr Code data is: $qrData', subject: 'My QR Code Link'),
    );
    return null;
  }

  static void copyQrDataToClipboard(String qrData) {
    Clipboard.setData(ClipboardData(text: qrData));
  }

  static Future<Uint8List?> captureQrCodeAsImage() async {
    try {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      if (kDebugMode) {
        print("Error capturing QR code for save: $e");
      }
      return null;
    }
  }

  static void shareQrCodeImage(String qrData) async {
    final bytes = await captureQrCodeAsImage();
    if (bytes == null) {
      if (kDebugMode) {
        print("Image capture failed.");
      }
      return;
    }
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/my_qr_code.png';
    final file = File(path);
    await file.writeAsBytes(bytes);
    await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
  }

  static void saveQrCodeImageToGallery(BuildContext context) async {
    final bytes = await captureQrCodeAsImage();
    if (bytes == null) {
      ShortMessage.showErrorMessage(
        context,
        "Error: QR code image capture failed.",
      );
      return;
    }
    final result = await ImageGallerySaverPlus.saveImage(
      bytes,
      quality: 90,
      name: "QR_Code_${DateTime.now().millisecondsSinceEpoch}",
    );
    if (result != null && result['isSuccess']) {
      ShortMessage.showSuccessMessage(
        context,
        "✅ QR Code saved successfully to Gallery!",
      );
    } else {
      ShortMessage.showErrorMessage(
        context,
        "❌ Failed to save QR Code. Check permissions.",
      );
    }
  }
}
