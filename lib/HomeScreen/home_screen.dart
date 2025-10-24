import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/Message/flutter_toast_message.dart';
import 'package:qr_code_scanner/Result/qr_code_result.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:vibration/vibration.dart';

import '../SharedPreference/user_id_services.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  double _sliderValue = 0.0;
  final double _zoomStep = 0.1;
  bool isTorchOn = false;
  String? qrCodeLink;
  File? image;
  String? imageUrl;
  bool vibrateSwitch =false;
  bool beepSwitch =true;
  final picker = ImagePicker();
  static final _audioPlayer = AudioPlayer();
  final databaseReference = FirebaseDatabase.instance.ref("ScannedData");
  final beepVibrateDatabaseRef = FirebaseDatabase.instance.ref("Switch");

  @override
  void initState() {
    super.initState();
    switchStoringData();
  }
  @override
  void dispose() {
    Controllers.scannerController.dispose();
    super.dispose();
  }


  Future<void> switchStoringData() async {
    UserIdServices userIdServices = UserIdServices();
    final deviceId = await userIdServices.getOrCreateUserId();
    await beepVibrateDatabaseRef.child(deviceId).once().then((snapshot) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          vibrateSwitch = data["VibrateSwitch"] ?? false;
          beepSwitch = data["BeepSwitch"] ?? false;
        });
      }
    });
  }

  Future<void> soundEffectOnCapturingQrCode() async {


    if (vibrateSwitch) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 500);
        print(" vibration is accour!:");
      }
    }
   else if (beepSwitch) {
      await _audioPlayer.play(volume: 100.0,
          AssetSource('audio/scanner-beep.mp3'));
      print(" Beep is accour!:");
    }
   else{
     if (kDebugMode) {
       print("No Switch is on or no vibration is accour!:");
     }
    }
  }

  Future<void> saveScanDataResultToDatabase(String scanResult) async {
    final userIdService = UserIdServices();
    final deviceId = await userIdService.getOrCreateUserId();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    databaseReference
        .child(deviceId)
        .child(id)
        .set({"id": id, "dateTime": dateTime, "scanResult": scanResult});
  }

  final dateTime = DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.now());

  void _changeZoom(bool zoomIn) {
    double newZoomValue = _sliderValue;
    if (zoomIn) {
      newZoomValue = (_sliderValue + _zoomStep).clamp(0.0, 1.0);
    } else {
      newZoomValue = (_sliderValue - _zoomStep).clamp(0.0, 1.0);
    }
    if (newZoomValue != _sliderValue) {
      setState(() {
        _sliderValue = newZoomValue;
      });
      Controllers.scannerController.setZoomScale(newZoomValue);
    }
  }

  Future<void> scanFromGalleryImageAndUpload() async {
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
    setState(() {
      image = selectedFile;
      qrCodeLink = null;
    });
    final capture = await Controllers.scannerController.analyzeImage(selectedFile.path);
    String? scannedCode;
    if (capture != null && capture.barcodes.isNotEmpty) {
      scannedCode = capture.barcodes.first.rawValue;
    }
    if (scannedCode != null) {
      setState(() {
        qrCodeLink = scannedCode;
      });
      if (mounted) {
        saveScanDataResultToDatabase(qrCodeLink!);
        soundEffectOnCapturingQrCode();
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => QrCodeResult(qrCodeLink!)),
        );
        if (mounted) {
          setState(() {
            image = null;
            qrCodeLink = null;
          });
          Controllers.scannerController.start();
        }
      }
    } else {
      setState(() {
        image = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No QR Code found in the image.'),
        ),
      );
      Controllers.scannerController.start();
    }
  }


  @override
  Widget build(BuildContext context) {
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
                            scanFromGalleryImageAndUpload();
                          },
                          child: Image.asset("assets/images/ImageIcon.png"),
                        ),
                        InkWell(
                          onTap: () async {
                            await Controllers.scannerController.toggleTorch();
                            setState(() {
                              isTorchOn = !isTorchOn;
                            });
                          },
                          child: isTorchOn
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
                                    if (code != null && qrCodeLink == null) {
                                      Controllers.scannerController.stop();
                                      soundEffectOnCapturingQrCode();
                                      setState(() {
                                        qrCodeLink = code;
                                      });
                                      saveScanDataResultToDatabase(code);
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
                                        setState(() {
                                          image = null;
                                          qrCodeLink = null;
                                        });
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
                          _changeZoom(false);
                        },
                        child: Text(
                          '-',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      Slider(
                        value: _sliderValue,
                        min: 0.0,
                        max: 1.0,
                        divisions: 100,
                        onChanged: (double newValue) {
                          setState(() {
                            _sliderValue = newValue;
                          });
                          Controllers.scannerController.setZoomScale(newValue);
                        },
                        activeColor: Colors.amber,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.amber,
                      ),
                      InkWell(
                        onTap: () {
                          _changeZoom(true);
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
