import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/SavingCreateQrCode/save_qr_code_services.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_bloc.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_event.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_state.dart';
import 'package:qr_code_scanner/bloc/gallery_image/gallery_image_bloc.dart';
import 'package:qr_code_scanner/constants/gallery_selected_image.dart';
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
    // final cameraController = Get.find<QrCameraController>();
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
                        BlocBuilder<GalleryImageBloc, GalleryImageState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                GallerySelectedImage.scanFromGalleryImageAndUpload(
                                  context: context,
                                  // qrLink: state.qrLink,
                                  // scannedData: state.scannedCode,
                                  // selectedImage: state.selectedFile,
                                );
                              },
                              child: Image.asset("assets/images/ImageIcon.png"),
                            );
                          },
                        ),
                        BlocBuilder<ChangeCameraBloc, ChangeCameraState>(
                          buildWhen: (previous, current) =>
                              previous.isTorchOn != current.isTorchOn,
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                await scannerController.toggleTorch();
                                context.read<ChangeCameraBloc>().add(
                                  SetTouchChange(),
                                );
                              },
                              child: state.isTorchOn
                                  ? Icon(
                                      Icons.flash_on,
                                      color: Colors.amber.shade600,
                                    )
                                  : Image.asset("assets/images/TorchIcon.png"),
                            );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            scannerController.switchCamera();
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
                        child: BlocBuilder<GalleryImageBloc, GalleryImageState>(
                          buildWhen: (previous, current) =>
                              previous.file != current.file,
                          builder: (context, state) {
                            return SizedBox(
                              width: 290,
                              height: 290,
                              child: MobileScanner(
                                controller: scannerController,
                                onDetect: (capture) async {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;
                                  final String? code = barcodes.isNotEmpty
                                      ? barcodes.first.rawValue
                                      : null;
                                  if (code != null) {
                                    scannerController.stop();
                                    context.read<ChangeCameraBloc>().add(
                                      SoundEffectOnCapturingQrCode(),
                                    );
                                    context.read<GalleryImageBloc>().add(
                                      SetQrLink(scannedCode: code),
                                    );
                                    SaveQrCode.saveScanDataResultToDatabase(
                                      code,
                                      context,
                                    );
                                    context.read<GalleryImageBloc>().add(
                                      SetImageQrLinkNull(),
                                    );
                                    await Navigator.pushNamed(
                                      context,
                                      RoutesName.resultScreen,
                                      arguments: code,
                                    );

                                    if (kDebugMode) {
                                      print("The Scanned link is :$code");
                                    }
                                    if (mounted) {
                                      scannerController.start();
                                    }
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Image.asset("assets/images/CameraPic.png"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: BlocBuilder<ChangeCameraBloc, ChangeCameraState>(
                    buildWhen: (previous, current) =>
                        previous.sliderValues != current.sliderValues,
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<ChangeCameraBloc>().add(
                                ChangeZoom(zoomIn: false),
                              );
                              ;
                            },
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Slider(
                            value: state.sliderValues,
                            min: 0.0,
                            max: 1.0,
                            divisions: 100,
                            onChanged: (double newValue) {
                              context.read<ChangeCameraBloc>().add(
                                SetSliderValue(newValue: newValue),
                              );
                              scannerController.setZoomScale(newValue);
                            },
                            activeColor: Colors.amber,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.amber,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<ChangeCameraBloc>().add(
                                ChangeZoom(zoomIn: true),
                              );
                            },
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 29,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
