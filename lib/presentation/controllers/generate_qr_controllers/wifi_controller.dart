import 'package:qr_code_scanner/core/util/validators.dart';

class WifiController {
  final String networkName, networkPassword;

  WifiController({required this.networkPassword, required this.networkName});

  String? validity() {
    final textError = Validation.textValidation("Wifi name")(networkName);
    if (textError != null) {
      return textError;
    }
    final passwordError = Validation.wifiPasswordLengthValidation("password")(
      networkPassword,
    );
    if (passwordError != null) {
      return passwordError;
    }
    return null;
  }
}
