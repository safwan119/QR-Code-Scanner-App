import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../SharedPreference/user_id_services.dart';

class SaveQrCode {
  static final databaseReference = FirebaseDatabase.instance.ref("ScannedData");
  static final firebaseDatabase = FirebaseDatabase.instance.ref("CreateQrCode");
  static final dateTime = DateFormat(
    "dd MMMM yyyy, hh:mm a",
  ).format(DateTime.now());

  Future<void> saveQrCodeData(String qrData) async {
    final deviceId = await PrefUtils.getOrCreateUserId();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    firebaseDatabase
        .child(deviceId)
        .child(id)
        .set({"id": id, "dateTime": dateTime, "scanResult": qrData})
        .onError((error, stackTrace) {
          debugPrint(
            "Error while fetching the data and this is:$error and stackTrace is :$stackTrace",
          );
        });
  }

  static Future<void> saveScanDataResultToDatabase(
    String scanResult,
    BuildContext context,
  ) async {
    final deviceId = await PrefUtils.getOrCreateUserId();
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    databaseReference.child(deviceId).child(id).set({
      "id": id,
      "dateTime": dateTime,
      "scanResult": scanResult,
    });
  }
}
