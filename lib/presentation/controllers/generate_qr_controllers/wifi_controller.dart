import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class WifiController extends RxController {
  String? validity() {
    final textError = Validation.textValidation("Wifi name")(
      Controllers.networkNameController.text,
    );
    if (textError != null) {
      return textError;
    }
    final passwordError = Validation.wifiPasswordLengthValidation(
      "password",
      8,
      maxLength: 12,
    )(Controllers.passwordController.text);
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }

  void generateWifiQr() {
    final input =
        "WIFI:S:${Controllers.networkName};T:WPA;P:${Controllers.password};H:false;";

    final wifiValidationError = validity();
    if (wifiValidationError != null) {
      ShortMessage.showErrorMessage(wifiValidationError);
      return;
    }
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
