import 'package:qr_code_scanner/core/util/validators.dart';

class EmailController {
  final String value;

  EmailController({required this.value});

  String? validity() {
    final emailError = Validation.emailValidity("Email")(value);
    if (emailError != null) {
      return emailError;
    }
    return null;
  }
}
