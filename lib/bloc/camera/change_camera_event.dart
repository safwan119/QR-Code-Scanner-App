import 'package:equatable/equatable.dart';

abstract class ChangeCameraEvent extends Equatable {
  ChangeCameraEvent();
}

class SwitchStoringDataChange extends ChangeCameraEvent {
  final String deviceID;

  SwitchStoringDataChange({required this.deviceID});

  @override
  List<Object?> get props => [deviceID];
}

class RatingDataStoreChange extends ChangeCameraEvent {
  final String deviceID;

  RatingDataStoreChange({required this.deviceID});

  @override
  List<Object?> get props => [deviceID];
}

class SoundEffectOnCapturingQrCode extends ChangeCameraEvent {
  @override
  List<Object?> get props => [];
}

class SetTouchChange extends ChangeCameraEvent {
  @override
  List<Object?> get props => [];
}

class SetVibrateSwitch extends ChangeCameraEvent {
  final bool vibrateValue;

  SetVibrateSwitch({required this.vibrateValue});

  @override
  List<Object?> get props => [vibrateValue];
}

class SetBeepSwitch extends ChangeCameraEvent {
  final bool beepValue;

  SetBeepSwitch({required this.beepValue});

  @override
  List<Object?> get props => [beepValue];
}

class SetRatingChange extends ChangeCameraEvent {
  final double rating;

  SetRatingChange({required this.rating});

  @override
  List<Object?> get props => [rating];
}

class ChangeZoom extends ChangeCameraEvent {
  final bool zoomIn;

  ChangeZoom({required this.zoomIn});

  @override
  List<Object?> get props => [zoomIn];
}

class SetSliderValue extends ChangeCameraEvent {
  final double newValue;

  SetSliderValue({required this.newValue});

  @override
  List<Object?> get props => [newValue];
}
