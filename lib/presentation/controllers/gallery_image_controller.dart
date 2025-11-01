import 'dart:io';

import 'package:get/get.dart';

import '../../constants/public_data.dart';

class GalleryImageController extends RxController {
  RxString qrCodeLink = "".obs;
  RxString imageUrl = "".obs;

  setImage(File selectedFile) {
    image = selectedFile;
    qrCodeLink.value = "";
  }

  setQrLink(String scannedCode) {
    qrCodeLink.value = scannedCode;
  }

  setNull() {
    image = null;
    qrCodeLink = "".obs;
  }

  setImageNull() {
    image = null;
  }
}
