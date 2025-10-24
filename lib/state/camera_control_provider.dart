import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/state/device_id_provider.dart';
import 'package:vibration/vibration.dart';

import '../constants/controllers.dart';

class CameraControlProvider with ChangeNotifier {
  final beepVibrateDatabaseRef = FirebaseDatabase.instance.ref("Switch");
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref("Rating");
  static final _audioPlayer = AudioPlayer();
  double _zoomStep = 0.1;

  double _sliderValue = 0.0;

  double get sliderValue => _sliderValue;

  double _rating = 0.0;

  double get rating => _rating;

  bool _vibrateSwitch = false;
  bool _beepSwitch = true;

  bool _isTorchOn = false;

  bool get isTorchOn => _isTorchOn;

  bool get vibrateSwitch => _vibrateSwitch;

  bool get beepSwitch => _beepSwitch;

  Future<void> switchStoringData(BuildContext context) async {
    final idProvider = Provider.of<DeviceIdProvider>(context, listen: false);
    await idProvider.initializeDeviceId();
    await beepVibrateDatabaseRef.child(idProvider.deviceId).once().then((
      snapshot,
    ) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        _vibrateSwitch = data["VibrateSwitch"] ?? false;
        _beepSwitch = data["BeepSwitch"] ?? false;
      }
    });
    notifyListeners();
  }

  Future<void> ratingDataStore(BuildContext context) async {
    final idProvider = Provider.of<DeviceIdProvider>(context, listen: false);
    await idProvider.initializeDeviceId();
    await firebaseDatabaseReference.child(idProvider.deviceId).once().then((
      snapshot,
    ) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        final dynamic ratingValue = data["rating"];
        if (ratingValue is num) {
          _rating = ratingValue.toDouble();
        } else {
          _rating = 0.0;
        }
        print("The rating in this id is :$_rating");
      }
    });
  }

  Future<void> soundEffectOnCapturingQrCode() async {
    if (_vibrateSwitch) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 500);
        print(" vibration is use!:");
      }
    } else if (_beepSwitch) {
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
    _isTorchOn = !_isTorchOn;
    notifyListeners();
  }

  setVibrateSwitch(value) {
    _vibrateSwitch = value;
    _beepSwitch = !value;
    notifyListeners();
  }

  setBeepSwitch(value) {
    _beepSwitch = value;
    _vibrateSwitch = !value;
    notifyListeners();
  }

  setRating(double rating) {
    _rating = rating;
  }

  changeZoom(bool zoomIn) {
    double newZoomValue = _sliderValue;
    if (zoomIn) {
      newZoomValue = (_sliderValue + _zoomStep).clamp(0.0, 1.0);
    } else {
      newZoomValue = (_sliderValue - _zoomStep).clamp(0.0, 1.0);
    }
    if (newZoomValue != _sliderValue) {
      _sliderValue = newZoomValue;
      Controllers.scannerController.setZoomScale(newZoomValue);
    }
    notifyListeners();
  }

  setSliderValue(double newValue) {
    _sliderValue = newValue;
    notifyListeners();
  }
}
