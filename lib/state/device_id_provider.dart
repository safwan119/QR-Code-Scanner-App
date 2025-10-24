import 'package:flutter/material.dart';

import '../SharedPreference/user_id_services.dart';

class DeviceIdProvider with ChangeNotifier{
  UserIdServices userIdServices = UserIdServices();
  String _deviceId="";
  String get deviceId=>_deviceId;

  Future<void> initializeDeviceId() async {
    _deviceId = await userIdServices.getOrCreateUserId();
    notifyListeners();
  }

  Future<void> deleteDeviceId() async {
    _deviceId = await userIdServices.clearUserId();
    notifyListeners();
  }
}