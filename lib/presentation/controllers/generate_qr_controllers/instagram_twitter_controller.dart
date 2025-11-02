import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class InstagramTwitterController extends RxController {
  String? instagramValidity() {
    final instagramUsernameError = Validation.usernameValidity(
      "Instagram UserName",
    )(Controllers.userNameController.text);
    if (instagramUsernameError != null) {
      return instagramUsernameError;
    }
    return null;
  }

  String? twitterValidity() {
    final twitterUsernameError = Validation.usernameValidity(
      "Twitter UserName",
    )(Controllers.twitterController.text);
    if (twitterUsernameError != null) {
      return twitterUsernameError;
    }
    return null;
  }

  void instagramUserQr() {
    final instagramValidation = instagramValidity();
    if (instagramValidation != null) {
      ShortMessage.showErrorMessage(instagramValidation);
      return;
    }
    final instagramUrl = "https://www.instagram.com/${Controllers.userName}";
    final qrData = instagramUrl;
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

  void twitterUserQr() {
    final twitterValidation = twitterValidity();
    if (twitterValidation != null) {
      ShortMessage.showErrorMessage(twitterValidation);
      return;
    }
    final input = "https://twitter.com/${Controllers.twitterUserName}";
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
