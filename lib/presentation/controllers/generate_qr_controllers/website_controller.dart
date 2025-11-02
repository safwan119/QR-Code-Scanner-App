import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class WebSiteController extends RxController {
  String? validity() {
    final urlError = Validation.websiteUrlValidity("website url")(
      Controllers.urlController.text,
    );
    if (urlError != null) {
      return urlError;
    }
    return null;
  }

  void generateWebsiteUrl() {
    final urlValidationError = validity();
    if (urlValidationError != null) {
      ShortMessage.showErrorMessage(urlValidationError);
      return;
    }
    final websiteUrlLink = Controllers.websiteUrl;
    final qrData = websiteUrlLink;
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
