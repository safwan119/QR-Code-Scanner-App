import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class EmailController extends RxController {
  String? validity() {
    final emailError = Validation.emailValidity("Email")(
      Controllers.emailController.text,
    );
    if (emailError != null) {
      return emailError;
    }
    return null;
  }

  void GenerateEmailQr() {
    final emailValidation = validity();
    if (emailValidation != null) {
      ShortMessage.showErrorMessage(emailValidation);
      return;
    }
    final emailInput = "mailto:${Controllers.emailAddress}";
    final qrData = emailInput;
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
