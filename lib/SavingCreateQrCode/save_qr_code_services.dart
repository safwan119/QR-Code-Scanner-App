import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/controllers/user_id_controller.dart';
import '../SharedPreference/user_id_services.dart';

class SaveQrCode{
  static final databaseReference = FirebaseDatabase.instance.ref("ScannedData");
  static final firebaseDatabase=FirebaseDatabase.instance.ref("CreateQrCode");
  static final dateTime=DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.now());
  Future<void> saveQrCodeData(String qrData) async {
    final userIdService = UserIdServices();
    final deviceId = await userIdService.getOrCreateUserId();
    final id=DateTime.now().millisecondsSinceEpoch.toString();
    firebaseDatabase.child(deviceId).child(id).set({
      "id":id,
      "dateTime":dateTime,
      "scanResult":qrData,
    }).onError((error,stackTrace){
      ShortMessage.showErrorMessage(error.toString());
    });

  }
  static Future<void> saveScanDataResultToDatabase(String scanResult,BuildContext context) async {
    final userId=Get.find<UserIdController>();
    await userId.initializeDeviceId();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    databaseReference.child(userId.deviceId.value).child(id).set({
      "id": id,
      "dateTime": dateTime,
      "scanResult": scanResult,
    });
  }

}