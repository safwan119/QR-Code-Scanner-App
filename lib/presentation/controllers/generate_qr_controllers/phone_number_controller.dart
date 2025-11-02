import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../route/routes_name.dart';

class PhoneNumberController extends RxController {
  String? phoneNumberValidity() {
    final phoneNumberError = Validation.phoneNumberValidity("Phone Number")(
      Controllers.phoneController.text,
    );
    if (phoneNumberError != null) {
      return phoneNumberError;
    }
    return null;
  }

  String? whatsappNumberValidity() {
    final whatsappNumberError = Validation.phoneNumberValidity(
      "Whatsapp Number",
    )(Controllers.whatsappNumberController.text);
    if (whatsappNumberError != null) {
      return whatsappNumberError;
    }
    return null;
  }

  void generatePhoneNumberQr() {
    final numberValidation = phoneNumberValidity();
    if (numberValidation != null) {
      ShortMessage.showErrorMessage(numberValidation);
      return;
    }
    final cleanNumber = Controllers.phoneNumber.replaceAll(
      RegExp(r'[^\d+]'),
      '',
    );
    final input = "tel:$cleanNumber";
    final qrData = input;
    SaveQrCode saveQrCode = SaveQrCode();
    try {
      saveQrCode.saveQrCodeData(qrData);
      ShortMessage.showSuccessMessage("Qr Generated Successfully");
      Get.toNamed(RoutesName.qrCodeScreen, arguments: qrData);
    } catch (e) {
      ShortMessage.showErrorMessage("Error:$e");
    }
  }

  void generateWhatsappNumberQr() {
    final whatsappNumberValidation = whatsappNumberValidity();
    if (whatsappNumberValidation != null) {
      ShortMessage.showErrorMessage(whatsappNumberValidation);
      return;
    }

    var whatsappNumber = Controllers.whatsappNumberController.text;
    final input = "http://wa.me/$whatsappNumber";

    final qrData = input;
    SaveQrCode saveQrCode = SaveQrCode();
    try {
      saveQrCode.saveQrCodeData(qrData);
      ShortMessage.showSuccessMessage("Qr Generated Successfully");
      Get.toNamed(RoutesName.qrCodeScreen, arguments: qrData);
    } catch (e) {
      ShortMessage.showErrorMessage("Error:$e");
    }
  }
}
