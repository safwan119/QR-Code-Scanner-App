import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/presentation/controllers/user_id_controller.dart';
import 'package:vibration/vibration.dart';

import '../../constants/controllers.dart';

class QrCameraController extends RxController {
  final beepVibrateDatabaseRef = FirebaseDatabase.instance.ref("Switch");
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref("Rating");
  static final _audioPlayer = AudioPlayer();
  RxDouble zoomStep = 0.1.obs;

  RxDouble sliderValues = 0.0.obs;

  RxDouble rating = 0.0.obs;

  RxBool vibrateSwitch = false.obs;
  RxBool beepSwitch = true.obs;

  RxBool isTorchOn = false.obs;

  Future<void> switchStoringData(BuildContext context) async {
    final userId = Get.find<UserIdController>();
    await userId.initializeDeviceId();
    await beepVibrateDatabaseRef.child(userId.deviceId.value).once().then((
      snapshot,
    ) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        vibrateSwitch.value = data["VibrateSwitch"] ?? false;
        beepSwitch.value = data["BeepSwitch"] ?? false;
      }
    });
  }

  Future<void> ratingDataStore(BuildContext context) async {
    final userId = Get.find<UserIdController>();
    await userId.initializeDeviceId();
    await firebaseDatabaseReference.child(userId.deviceId.value).once().then((
      snapshot,
    ) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        final dynamic ratingValue = data["rating"];
        if (ratingValue is num) {
          rating.value = ratingValue.toDouble();
        } else {
          rating.value = 0.0;
        }
        print("The rating in this id is :${rating.value}");
      }
    });
  }

  Future<void> soundEffectOnCapturingQrCode() async {
    if (vibrateSwitch.value) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 500);
        print(" vibration is use!:");
      }
    } else if (beepSwitch.value) {
      await _audioPlayer.play(
        volume: 100.0,
        AssetSource('audio/scanner-beep.mp3'),
      );
      print(" Beep is use!:");
    } else {
      if (kDebugMode) {
        print("No Switch is on or no vibration is here!:");
      }
    }
  }

  setTouch() {
    isTorchOn.value = !isTorchOn.value;
  }

  setVibrateSwitch(value) {
    vibrateSwitch.value = value;
    beepSwitch.value = !value;
  }

  setBeepSwitch(value) {
    beepSwitch.value = value;
    vibrateSwitch.value = !value;
  }

  setRating(double rating) {
    this.rating.value = rating;
  }

  changeZoom(bool zoomIn) {
    double newZoomValue = sliderValues.value;
    if (zoomIn) {
      newZoomValue = (sliderValues.value + zoomStep.value).clamp(0.0, 1.0);
    } else {
      newZoomValue = (sliderValues.value - zoomStep.value).clamp(0.0, 1.0);
    }
    if (newZoomValue != sliderValues.value) {
      sliderValues.value = newZoomValue;
      Controllers.scannerController.setZoomScale(newZoomValue);
    }
  }

  setSliderValue(double newValue) {
    sliderValues.value = newValue;
  }
}
