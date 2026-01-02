import 'package:equatable/equatable.dart';

class PreferenceState extends Equatable {
  final String userDeviceId;

  PreferenceState({this.userDeviceId = ""});

  @override
  List<Object?> get props => [];

  PreferenceState copyWith({String? userDeviceId}) =>
      PreferenceState(userDeviceId: userDeviceId ?? this.userDeviceId);
}
