import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class ButtonClickPaths {
  static buttonClick(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushNamed(context, RoutesName.textScreen);
    } else if (index == 1) {
      Navigator.pushNamed(context, RoutesName.websiteScreen);
    } else if (index == 2) {
      Navigator.pushNamed(context, RoutesName.wifiScreen);
    } else if (index == 3) {
      Navigator.pushNamed(context, RoutesName.eventScreen);
    } else if (index == 4) {
      Navigator.pushNamed(context, RoutesName.contactScreen);
    } else if (index == 5) {
      Navigator.pushNamed(context, RoutesName.businessScreen);
    } else if (index == 6) {
      Navigator.pushNamed(context, RoutesName.locationScreen);
    } else if (index == 7) {
      Navigator.pushNamed(context, RoutesName.whatsappScreen);
    } else if (index == 8) {
      Navigator.pushNamed(context, RoutesName.emailScreen);
    } else if (index == 9) {
      Navigator.pushNamed(context, RoutesName.twitterScreen);
    } else if (index == 10) {
      Navigator.pushNamed(context, RoutesName.instagramScreen);
    } else if (index == 11) {
      Navigator.pushNamed(context, RoutesName.phoneScreen);
    }
  }
}
