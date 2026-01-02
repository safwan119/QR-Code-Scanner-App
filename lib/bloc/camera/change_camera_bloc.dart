import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_state.dart';
import 'package:vibration/vibration.dart';

import '../../constants/public_data.dart';
import 'change_camera_event.dart';

class ChangeCameraBloc extends Bloc<ChangeCameraEvent, ChangeCameraState> {
  final beepVibrateDatabaseRef = FirebaseDatabase.instance.ref("Switch");
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref("Rating");
  static final _audioPlayer = AudioPlayer();

  ChangeCameraBloc() : super(ChangeCameraState()) {
    on<SwitchStoringDataChange>(_switchStoringDataChange);
    on<RatingDataStoreChange>(_ratingDataStoreChange);
    on<SoundEffectOnCapturingQrCode>(_soundEffectOnCapturingQrCode);
    on<SetTouchChange>(_setTouchChange);
    on<SetVibrateSwitch>(_setVibrateSwitch);
    on<SetBeepSwitch>(_setBeepSwitch);
    on<ChangeZoom>(_changeZoom);
    on<SetRatingChange>(_setRatingChange);
    on<SetSliderValue>(_setSliderValue);
  }

  void _switchStoringDataChange(
    SwitchStoringDataChange event,
    Emitter<ChangeCameraState> emit,
  ) async {
    await beepVibrateDatabaseRef.child(event.deviceID).once().then((snapshot) {
      final data = snapshot.snapshot.value as Map?;
      if (data != null) {
        emit(
          state.copyWith(
            userId: event.deviceID,
            vibrateSwitch: data["VibrateSwitch"] ?? false,
            beepSwitch: data["BeepSwitch"] ?? false,
          ),
        );
      }
    });
  }

  void _ratingDataStoreChange(
    RatingDataStoreChange event,
    Emitter<ChangeCameraState> emit,
  ) async {
    final snapshot = await firebaseDatabaseReference
        .child(event.deviceID)
        .once();

    final data = snapshot.snapshot.value as Map?;

    double rating = 0.0;

    if (data != null && data["rating"] is num) {
      rating = (data["rating"] as num).toDouble();
    }

    emit(state.copyWith(userId: event.deviceID, rating: rating));
  }

  Future<void> _soundEffectOnCapturingQrCode(
    SoundEffectOnCapturingQrCode event,
    Emitter<ChangeCameraState> emit,
  ) async {
    emit(
      state.copyWith(
        beepSwitch: state.beepSwitch,
        vibrateSwitch: state.vibrateSwitch,
      ),
    );
    if (state.vibrateSwitch) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 500);
        debugPrint(" vibration is use!:");
      }
    } else if (state.beepSwitch) {
      await _audioPlayer.play(
        volume: 100.0,
        AssetSource('audio/scanner-beep.mp3'),
      );
      debugPrint(" Beep is use!:");
    } else {
      debugPrint("No Switch is on or no vibration is here!:");
    }
  }

  void _setTouchChange(SetTouchChange event, Emitter<ChangeCameraState> emit) {
    emit(state.copyWith(isTorchOn: !state.isTorchOn));
  }

  void _setVibrateSwitch(
    SetVibrateSwitch event,
    Emitter<ChangeCameraState> emit,
  ) {
    emit(
      state.copyWith(
        vibrateSwitch: event.vibrateValue,
        beepSwitch: !event.vibrateValue,
      ),
    );
  }

  void _setBeepSwitch(SetBeepSwitch event, Emitter<ChangeCameraState> emit) {
    emit(
      state.copyWith(
        vibrateSwitch: !event.beepValue,
        beepSwitch: event.beepValue,
      ),
    );
  }

  void _changeZoom(ChangeZoom event, Emitter<ChangeCameraState> emit) {
    double newZoomValue = state.sliderValues;
    if (event.zoomIn) {
      newZoomValue = (state.sliderValues + state.zoomStep).clamp(0.0, 1.0);
    } else {
      newZoomValue = (state.sliderValues - state.zoomStep).clamp(0.0, 1.0);
    }
    if (newZoomValue != state.sliderValues) {
      emit(state.copyWith(sliderValues: newZoomValue));
      scannerController.setZoomScale(newZoomValue);
    }
  }

  void _setRatingChange(
    SetRatingChange event,
    Emitter<ChangeCameraState> emit,
  ) {
    emit(state.copyWith(rating: event.rating));
  }

  void _setSliderValue(SetSliderValue event, Emitter<ChangeCameraState> emit) {
    emit(state.copyWith(sliderValues: event.newValue));
  }
}
