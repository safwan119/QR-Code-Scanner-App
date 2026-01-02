import 'package:qr_code_scanner/core/util/validators.dart';

class PhoneNumberController {
  final String value;

  PhoneNumberController({required this.value});

  String? phoneNumberValidity() {
    final phoneNumberError = Validation.phoneNumberValidity("Phone Number")(
      value,
    );
    if (phoneNumberError != null) {
      return phoneNumberError;
    }
    return null;
  }

  String? whatsappNumberValidity() {
    final whatsappNumberError = Validation.phoneNumberValidity(
      "Whatsapp Number",
    )(value);
    if (whatsappNumberError != null) {
      return whatsappNumberError;
    }
    return null;
  }
}
