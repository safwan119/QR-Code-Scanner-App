import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/shared_apk_and_qr_data.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import 'package:qr_flutter/qr_flutter.dart' as qrflutter;

import '../../constants/public_data.dart';

class QRCode extends StatelessWidget {
  QRCode({super.key, required this.qrData});

  final String qrData;

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
                  child: Image.asset(AppImages.arrowBackImage),
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
            SizedBox(height: AppSize.h4),
            RepaintBoundary(
              key: qrKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade600),
                ),
                child: qrflutter.QrImageView(
                  data: qrData,
                  version: qrflutter.QrVersions.auto,
                  size: 250.0,

                  backgroundColor: Colors.white,
                  dataModuleStyle: qrflutter.QrDataModuleStyle(
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
                        SharedApkAndQrData.shareQrCodeImage(qrData);
                      },
                      child: Image.asset("assets/images/SharePic.png"),
                    ),
                    const SizedBox(height: 4),
                    Text("Share", style: textStyle(fontSize: 20)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/SaveBackground.png"),
                        InkWell(
                          onTap: () {
                            SharedApkAndQrData.saveQrCodeImageToGallery(
                              context,
                            );
                          },
                          child: Image.asset("assets/images/SaveIcon.png"),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("Save", style: textStyle(fontSize: 20)),
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
