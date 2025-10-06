import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import '../Message/flutter_toast_message.dart';
import '../SharedPreference/user_id_services.dart';

class SaveQrCode{
  final firebaseDatabase=FirebaseDatabase.instance.ref("CreateQrCode");
  Future<void> saveQrCodeData(String qrData) async {
    final userIdService = UserIdServices();
    final deviceId = await userIdService.getOrCreateUserId();
    final id=DateTime.now().millisecondsSinceEpoch.toString();
    final dateTime=DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.now());
    firebaseDatabase.child(deviceId).child(id).set({
      "id":id,
      "dateTime":dateTime,
      "scanResult":qrData,
    }).then((value){
      FlutterToastMessage().toastMessage("save Successfully");
    }).onError((error,stackTrace){
      FlutterToastMessage().toastMessage(error.toString());
    });

  }

}