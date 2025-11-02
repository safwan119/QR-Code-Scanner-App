import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class TextController extends RxController {
  String? validity() {
    final textError = Validation.textValidation("text")(
      Controllers.textController.text,
    );
    if (textError != null) {
      return textError;
    }

    return null;
  }

  void textGenerateQrCode() {
    final textValidationError = validity();
    if (textValidationError != null) {
      ShortMessage.showErrorMessage(textValidationError);
      return;
    }
    final qrData = Controllers.textName;
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
