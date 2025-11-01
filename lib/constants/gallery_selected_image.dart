import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/controllers/gallery_image_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/qr_camera_controller.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import 'controllers.dart';
import 'package:get/get.dart';

class GallerySelectedImage {
  static final picker = ImagePicker();

  static Future<void> scanFromGalleryImageAndUpload(
    BuildContext context,
  ) async {
    final imageController = Get.find<GalleryImageController>();
    final imagePicker = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (imagePicker == null) {
      ShortMessage.showErrorMessage("No image selected from gallery");
      return;
    }

    File selectedFile = File(imagePicker.path);
    Controllers.scannerController.stop();
    imageController.setImage(selectedFile);
    final capture = await Controllers.scannerController.analyzeImage(
      selectedFile.path,
    );
    String? scannedCode;
    if (capture != null && capture.barcodes.isNotEmpty) {
      scannedCode = capture.barcodes.first.rawValue;
    }
    if (scannedCode != null) {
      imageController.setQrLink(scannedCode);
      if (context.mounted) {
        SaveQrCode.saveScanDataResultToDatabase(
          imageController.qrCodeLink.value,
          context,
        );
        final soundController = Get.find<QrCameraController>();
        soundController.soundEffectOnCapturingQrCode();
        await Get.toNamed(RoutesName.resultScreen,arguments: imageController.qrCodeLink.value);
        if (context.mounted) {
          imageController.setNull();
          Controllers.scannerController.start();
        }
      }
    } else {
      imageController.setImageNull();
      ShortMessage.showErrorMessage('No QR Code found in the image.');
      Controllers.scannerController.start();
    }
  }
}
