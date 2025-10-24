import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart' as qrflutter;
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';

class QRCode extends StatefulWidget {
  final String qrData;

  const QRCode(this.qrData, {super.key});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final GlobalKey qrKey = GlobalKey();

  Future<Uint8List?> captureQrCodeAsImage() async {
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

  void shareQrCodeImage(String qrData) async {
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

  void saveQrCodeImageToGallery() async {
    final bytes = await captureQrCodeAsImage();
    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: QR code image capture failed.")),
      );
      return;
    }
    final result = await ImageGallerySaverPlus.saveImage(
      bytes,
      quality: 90,
      name: "QR_Code_${DateTime.now().millisecondsSinceEpoch}",
    );
    if (result != null && result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ QR Code saved successfully to Gallery!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Failed to save QR Code. Check permissions."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/ArrowBackPic.png"),
                ),
                Text(
                  "QR Code",
                  style: GoogleFonts.akayaTelivigala(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Colors.black,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          "Data",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          DateFormat(
                            "dd MMMM yyyy, hh:mm a",
                          ).format(DateTime.now()),
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            RepaintBoundary(
              key: qrKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade600),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.amber.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 10,
                  //   ),
                  // ],
                ),
                child: qrflutter.QrImageView(
                  data: widget.qrData,
                  version: qrflutter.QrVersions.auto,
                  size: 250.0,

                  backgroundColor: Colors.white,
                  dataModuleStyle:qrflutter.QrDataModuleStyle(
                    color: Colors.black,
                  ),
                  gapless: true,
                  errorStateBuilder: (cxt, err) {
                    return Center(
                      child: Text(
                        "Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        shareQrCodeImage(widget.qrData);
                      },
                      child: Image.asset("assets/images/SharePic.png"),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Share",
                      style: GoogleFonts.akayaTelivigala(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/SaveBackground.png",
                        ),
                        InkWell(onTap: () {
                          saveQrCodeImageToGallery();
                        },
                            child: Image.asset("assets/images/SaveIcon.png")),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Save",
                      style: GoogleFonts.akayaTelivigala(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
