import 'package:get/get.dart';

import '../../SharedPreference/user_id_services.dart';

class UserIdController extends GetxController{
  UserIdServices userIdServices = UserIdServices();
  RxString deviceId="".obs;

  Future<void> initializeDeviceId() async {
    deviceId.value = await userIdServices.getOrCreateUserId();
  }

  Future<void> deleteDeviceId() async {
    deviceId.value = await userIdServices.clearUserId();
  }
}