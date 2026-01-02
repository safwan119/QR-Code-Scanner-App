import 'package:qr_code_scanner/core/util/validators.dart';

class LocationController {
  final String value;

  LocationController({required this.value});

  String? validity() {
    final locationError = Validation.textValidation("Location")(value);
    if (locationError != null) {
      return locationError;
    }
    return null;
  }
}
