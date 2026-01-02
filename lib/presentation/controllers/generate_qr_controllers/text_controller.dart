import 'package:qr_code_scanner/core/util/validators.dart';

class TextController {
  final String value;

  TextController({required this.value});

  String? validity() {
    final textError = Validation.textValidation("text")(value);
    if (textError != null) {
      return textError;
    }

    return null;
  }
}
