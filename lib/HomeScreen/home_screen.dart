import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/SavingCreateQrCode/save_qr_code_services.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/constants/gallery_selected_image.dart';
import 'package:qr_code_scanner/presentation/controllers/gallery_image_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/qr_camera_controller.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../constants/public_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final cameraController=Get.find<QrCameraController>();
    final imageController=Get.find<GalleryImageController>();
    // final galleryImageProvider = Provider.of<GalleryImageProvider>(context);
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
                        Obx(()=>InkWell(
                          onTap: () async {
                            await Controllers.scannerController.toggleTorch();
                            cameraController.setTouch();
                          },
                          child:cameraController.isTorchOn.value
                              ? Icon(
                            Icons.flash_on,
                            color: Colors.amber.shade600,
                          )
                              : Image.asset("assets/images/TorchIcon.png"),
                        ),),
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
                              :
                           MobileScanner(
                            controller: Controllers.scannerController,
                            onDetect: (capture) async {
                              final List<Barcode> barcodes =
                                  capture.barcodes;
                              final String? code = barcodes.isNotEmpty
                                  ? barcodes.first.rawValue
                                  : null;
                              if (code != null) {
                                Controllers.scannerController.stop();
                                cameraController
                                    .soundEffectOnCapturingQrCode();
                                imageController.setQrLink(code);
                                SaveQrCode.saveScanDataResultToDatabase(
                                  code,
                                  context,
                                );
                                await Get.toNamed(RoutesName.resultScreen,arguments: code);
                                if (kDebugMode) {
                                  print("The Scanned link is :$code");
                                }
                                if (mounted) {
                                  imageController.setNull();
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
                  child: Obx(()=>Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      InkWell(
                        onTap: () {
                          cameraController.changeZoom(false);
                        },
                        child: Text(
                          '-',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      Slider(
                        value:cameraController.sliderValues.value,
                        min: 0.0,
                        max: 1.0,
                        divisions: 100,
                        onChanged: (double newValue) {
                          cameraController.setSliderValue(newValue);
                          Controllers.scannerController.setZoomScale(newValue);
                        },
                        activeColor: Colors.amber,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.amber,
                      ),
                      InkWell(
                        onTap: () {
                          cameraController.changeZoom(true);
                        },
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white, fontSize: 29),
                        ),
                      ),
                    ],
                  ),)

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
