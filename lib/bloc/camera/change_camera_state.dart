import 'package:equatable/equatable.dart';

class ChangeCameraState extends Equatable {
  final double zoomStep;

  final double sliderValues;

  final double rating;

   final bool vibrateSwitch;
  final bool beepSwitch;

  final bool isTorchOn;
  final String userId;

  ChangeCameraState({
    this.beepSwitch = true,
    this.isTorchOn = false,
    this.rating = 0.0,
    this.sliderValues = 0.0,
    this.vibrateSwitch = false,
    this.zoomStep = 0.1,
    this.userId = "",
  });

  @override
  List<Object?> get props => [
    beepSwitch,
    isTorchOn,
    rating,
    sliderValues,
    vibrateSwitch,
    zoomStep,
    userId,
  ];

  ChangeCameraState copyWith({
    double? zoomStep,
    double? sliderValues,
    double? rating,
    bool? vibrateSwitch,
    bool? beepSwitch,
    bool? isTorchOn,
    String? userId,
  }) => ChangeCameraState(
    beepSwitch: beepSwitch ?? this.beepSwitch,
    isTorchOn: isTorchOn ?? this.isTorchOn,
    rating: rating ?? this.rating,
    userId: userId ?? this.userId,
    sliderValues: sliderValues ?? this.sliderValues,
    vibrateSwitch: vibrateSwitch ?? this.vibrateSwitch,
    zoomStep: zoomStep ?? this.zoomStep,
  );
}
