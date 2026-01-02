import 'package:equatable/equatable.dart';

abstract class PreferenceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeDeviceId extends PreferenceEvent {}

class DeleteDeviceId extends PreferenceEvent {}
