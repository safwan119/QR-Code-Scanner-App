import 'package:get/get.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';

import '../../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../../constants/controllers.dart';
import '../../../constants/qr_code_outputs.dart';
import '../../../core/util/validators.dart';
import '../../../route/routes_name.dart';

class ContactController extends RxController {
  String? validity() {
    final firstNameTextError = Validation.textValidation("First Name")(
      Controllers.firstNameController.text,
    );
    if (firstNameTextError != null) {
      return firstNameTextError;
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
    final companyNameTextError = Validation.textValidation("Company Name")(
      Controllers.companyController.text,
    );
    if (companyNameTextError != null) {
      return companyNameTextError;
    }
    final jobNameTextError = Validation.textValidation("Job Name")(
      Controllers.jobController.text,
    );
    if (jobNameTextError != null) {
      return jobNameTextError;
    }
    final addressNameTextError = Validation.textValidation("Address")(
      Controllers.addressController.text,
    );
    if (addressNameTextError != null) {
      return addressNameTextError;
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
    return null;
  }

  void generateContractQr() {
    final contactValidation = validity();
    if (contactValidation != null) {
      ShortMessage.showErrorMessage(contactValidation);
      return;
    }
    final qrData = QrCodeOutputs.contactDetailOutputs;
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
