import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class LocationController extends RxController {
  String? validity() {
    final locationError = Validation.textValidation("Location")(
      Controllers.locationNameController.text,
    );
    if (locationError != null) {
      return locationError;
    }
    return null;
  }

  void generateLocationQr() {
    final locationValidation = validity();
    if (locationValidation != null) {
      ShortMessage.showErrorMessage(locationValidation);
      return;
    }
    final encodedLocation = Uri.encodeComponent(Controllers.locationName);
    final input =
        "https://www.google.com/maps/search/?api=1&query=$encodedLocation";
    final qrData = input;
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(qrData)
        .then((value) {
          ShortMessage.showSuccessMessage("Qr Generated Successfully");
        })
        .onError((error, stackTrace) {
          ShortMessage.showErrorMessage(error.toString());
        });
    Get.toNamed(RoutesName.qrCodeScreen, arguments: qrData);
  }
}
