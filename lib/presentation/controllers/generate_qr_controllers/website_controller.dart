import 'package:qr_code_scanner/core/util/validators.dart';


class WebSiteController{
  final String value;
  WebSiteController({required this.value});
  String? validity() {
    final urlError = Validation.websiteUrlValidity("website url")(
      value,
    );
    if (urlError != null) {
      return urlError;
    }
    return null;
  }
}
