import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Message/flutter_toast_message.dart';
import '../Result/qr_code_result.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../state/camera_control_provider.dart';
import '../state/gallery_image_provider.dart';
import 'controllers.dart';

class GallerySelectedImage {
  static final picker = ImagePicker();

 static Future<void> scanFromGalleryImageAndUpload(BuildContext context) async {
    final galleryImageProvider = Provider.of<GalleryImageProvider>(
      context,
      listen: false,
    );
    final imagePicker = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (imagePicker == null) {
      FlutterToastMessage().toastMessage("No image selected from gallery");
      return;
    }

    File selectedFile = File(imagePicker.path);
    Controllers.scannerController.stop();
    galleryImageProvider.setImage(selectedFile);
    final capture = await Controllers.scannerController.analyzeImage(
      selectedFile.path,
    );
    String? scannedCode;
    if (capture != null && capture.barcodes.isNotEmpty) {
      scannedCode = capture.barcodes.first.rawValue;
    }
    if (scannedCode != null) {
      galleryImageProvider.setQrLink(scannedCode);
      if (context.mounted) {
        SaveQrCode.saveScanDataResultToDatabase(
          galleryImageProvider.qrCodeLink!,
          context,
        );
        final soundProvider = Provider.of<CameraControlProvider>(
          context,
          listen: false,
        );
        soundProvider.soundEffectOnCapturingQrCode();
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                QrCodeResult(galleryImageProvider.qrCodeLink!),
          ),
        );
        if (context.mounted) {
          galleryImageProvider.setNull();
          Controllers.scannerController.start();
        }
      }
    } else {
      galleryImageProvider.setImageNull();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No QR Code found in the image.'),
        ),
      );
      Controllers.scannerController.start();
    }
  }
}
