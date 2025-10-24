import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/Result/qr_code_result.dart';
import 'package:qr_code_scanner/SavingCreateQrCode/save_qr_code_services.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/constants/gallery_selected_image.dart';
import 'package:qr_code_scanner/state/camera_control_provider.dart';
import 'package:qr_code_scanner/state/gallery_image_provider.dart';

import '../constants/public_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final cameraControlProvider = Provider.of<CameraControlProvider>(context);
    final galleryImageProvider = Provider.of<GalleryImageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset("assets/images/ExcludeImage.png"),
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .08),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            GallerySelectedImage.scanFromGalleryImageAndUpload(
                              context,
                            );
                          },
                          child: Image.asset("assets/images/ImageIcon.png"),
                        ),
                        InkWell(
                          onTap: () async {
                            await Controllers.scannerController.toggleTorch();
                            cameraControlProvider.setTouch();
                          },
                          child: cameraControlProvider.isTorchOn
                              ? Icon(
                                  Icons.flash_on,
                                  color: Colors.amber.shade600,
                                )
                              : Image.asset("assets/images/TorchIcon.png"),
                        ),
                        InkWell(
                          onTap: () {
                            Controllers.scannerController.switchCamera();
                          },
                          child: Image.asset(
                            "assets/images/FlipCameraIcon.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          width: 290,
                          height: 290,

                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : MobileScanner(
                                  controller: Controllers.scannerController,
                                  onDetect: (capture) async {
                                    final List<Barcode> barcodes =
                                        capture.barcodes;
                                    final String? code = barcodes.isNotEmpty
                                        ? barcodes.first.rawValue
                                        : null;
                                    if (code != null &&
                                        galleryImageProvider.qrCodeLink ==
                                            null) {
                                      Controllers.scannerController.stop();
                                      final soundProvider =
                                          Provider.of<CameraControlProvider>(
                                            context,
                                            listen: false,
                                          );
                                      soundProvider
                                          .soundEffectOnCapturingQrCode();
                                      galleryImageProvider.setQrLink(code);
                                      SaveQrCode.saveScanDataResultToDatabase(
                                        code,
                                        context,
                                      );
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              QrCodeResult(code),
                                        ),
                                      );
                                      if (kDebugMode) {
                                        print("The Scanned link is :$code");
                                      }
                                      if (mounted) {
                                        galleryImageProvider.setNull();
                                        Controllers.scannerController.start();
                                      }
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),

                    Image.asset("assets/images/CameraPic.png"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          cameraControlProvider.changeZoom(false);
                        },
                        child: Text(
                          '-',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      Slider(
                        value: cameraControlProvider.sliderValue,
                        min: 0.0,
                        max: 1.0,
                        divisions: 100,
                        onChanged: (double newValue) {
                          cameraControlProvider.setSliderValue(newValue);
                          Controllers.scannerController.setZoomScale(newValue);
                        },
                        activeColor: Colors.amber,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.amber,
                      ),
                      InkWell(
                        onTap: () {
                          cameraControlProvider.changeZoom(true);
                        },
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 29),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
