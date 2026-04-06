import 'package:bloc/bloc.dart';
import 'package:qr_code_scanner/SharedPreference/user_id_services.dart';
import 'package:qr_code_scanner/bloc/preference/preference_event.dart';
import 'package:qr_code_scanner/bloc/preference/preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferenceBloc() : super(PreferenceState()) {
    on<InitializeDeviceId>(_initializeDeviceId);
    on<DeleteDeviceId>(_deleteDeviceId);
  }

  void _initializeDeviceId(
    InitializeDeviceId event,
    Emitter<PreferenceState> emit,
  ) async {
    final userDeviceId = await PrefUtils.getOrCreateUserId();
    emit(state.copyWith(userDeviceId: userDeviceId));
  }

  void _deleteDeviceId(
    DeleteDeviceId event,
    Emitter<PreferenceState> emit,
  ) async {
    await PrefUtils.clearUserId();
    emit(state.copyWith());
  }
}
