import 'package:qr_code_scanner/core/util/validators.dart';

class InstagramTwitterController {
  final String value;

  InstagramTwitterController({required this.value});

  String? instagramValidity() {
    final instagramUsernameError = Validation.usernameValidity(
      "Instagram UserName",
    )(value);
    if (instagramUsernameError != null) {
      return instagramUsernameError;
    }
    return null;
  }

  String? twitterValidity() {
    final twitterUsernameError = Validation.usernameValidity(
      "Twitter UserName",
    )(value);
    if (twitterUsernameError != null) {
      return twitterUsernameError;
    }
    return null;
  }
}
