import 'package:get/get.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../constants/controllers.dart';
import '../../../constants/qr_code_outputs.dart';
import '../../../core/util/validators.dart';
import '../../../route/routes_name.dart';

class BusinessController extends RxController {
  String? validity() {
    final companyNameTextError = Validation.textValidation("Company Name")(
      Controllers.companyController.text,
    );
    if (companyNameTextError != null) {
      return companyNameTextError;
    }
    final industryNameTextError = Validation.textValidation(
      "IndustryName Name",
    )(Controllers.industryController.text);
    if (industryNameTextError != null) {
      return industryNameTextError;
    }

    final phoneNumberError = Validation.phoneNumberValidity("Phone Number")(
      Controllers.phoneController.text,
    );
    if (phoneNumberError != null) {
      return phoneNumberError;
    }
    final emailAddressError = Validation.emailValidity("Email")(
      Controllers.emailController.text,
    );
    if (emailAddressError != null) {
      return emailAddressError;
    }
    final websiteUrlValidity = Validation.websiteUrlValidity("Website Url")(
      Controllers.websiteController.text,
    );
    if (websiteUrlValidity != null) {
      return websiteUrlValidity;
    }
    final addressNameTextError = Validation.textValidation("Address")(
      Controllers.addressController.text,
    );
    if (addressNameTextError != null) {
      return addressNameTextError;
    }
    final countryNameTextError = Validation.textValidation("Country Name")(
      Controllers.countryController.text,
    );
    if (countryNameTextError != null) {
      return countryNameTextError;
    }
    final cityNameTextError = Validation.textValidation("City Name")(
      Controllers.cityController.text,
    );
    if (cityNameTextError != null) {
      return cityNameTextError;
    }
    return null;
  }

  void generateBusinessQr() {
    final businessValidation = validity();
    if (businessValidation != null) {
      ShortMessage.showErrorMessage(businessValidation);
      return;
    }
    try {
      final qrData = QrCodeOutputs.businessDetailOutput;
      SaveQrCode saveQrCode = SaveQrCode();
      saveQrCode.saveQrCodeData(qrData);
      ShortMessage.showSuccessMessage("Qr Generated Successfully");

      Get.toNamed(RoutesName.qrCodeScreen, arguments: qrData);
    } catch (e) {
      ShortMessage.showErrorMessage("Error:$e");
    }
  }
}
