import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_bloc.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_event.dart';
import 'package:qr_code_scanner/constants/public_data.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../bloc/gallery_image/gallery_image_bloc.dart';

class GallerySelectedImage {
  static final picker = ImagePicker();

  static Future<void> scanFromGalleryImageAndUpload({
    required BuildContext context,
    // required File? selectedImage,
    // required String scannedData,
    // required String qrLink,
  }) async {
    final imagePicker = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (imagePicker == null) {
      ShortMessage.showErrorMessage(context, "No image selected from gallery");
      return;
    }

    File selectedFile = File(imagePicker.path);

    scannerController.stop();
    context.read<GalleryImageBloc>().add(
      SetImageChange(selectedFile: selectedFile),
    );
    final capture = await scannerController.analyzeImage(selectedFile.path);
    String? scannedCode;
    if (capture != null && capture.barcodes.isNotEmpty) {
      scannedCode = capture.barcodes.first.rawValue;
    }
    if (scannedCode != null) {
      // scannedData = scannedCode;
      context.read<GalleryImageBloc>().add(SetQrLink(scannedCode: scannedCode));
      if (context.mounted) {
        SaveQrCode.saveScanDataResultToDatabase(scannedCode, context);
        context.read<ChangeCameraBloc>().add(SoundEffectOnCapturingQrCode());

        await Navigator.pushNamed(
          context,
          RoutesName.resultScreen,
          arguments: scannedCode,
        );
        if (context.mounted) {
          context.read<GalleryImageBloc>().add(SetImageQrLinkNull());
          scannerController.start();
        }
      }
    } else {
      context.read<GalleryImageBloc>().add(SetImageNull());
      ShortMessage.showErrorMessage(context, 'No QR Code found in the image.');
      scannerController.start();
    }
  }
}
