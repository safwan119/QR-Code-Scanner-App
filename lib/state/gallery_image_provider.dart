
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/public_data.dart';

class GalleryImageProvider with ChangeNotifier{
  String? _qrCodeLink;
  String? _imageUrl;
  String? get qrCodeLink=>_qrCodeLink;
  String? get imageUrl=>_imageUrl;

  setImage(File selectedFile){
    image=selectedFile;
    _qrCodeLink=null;
  }

  setQrLink(String scannedCode){
    _qrCodeLink = scannedCode;
  }

  setNull(){
    image = null;
    _qrCodeLink = null;
  }

  setImageNull(){
    image=null;
  }
}