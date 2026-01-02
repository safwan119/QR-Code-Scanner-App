import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class ButtonClickPaths {
  static buttonClick(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, RoutesName.textScreen);
        break;
      case 1:
        Navigator.pushNamed(context, RoutesName.websiteScreen);
        break;
      case 2:
        Navigator.pushNamed(context, RoutesName.wifiScreen);
        break;
      case 3:
        Navigator.pushNamed(context, RoutesName.eventScreen);
        break;
      case 4:
        Navigator.pushNamed(context, RoutesName.contactScreen);
        break;
      case 5:
        Navigator.pushNamed(context, RoutesName.businessScreen);
        break;
      case 6:
        Navigator.pushNamed(context, RoutesName.locationScreen);
        break;
      case 7:
        Navigator.pushNamed(context, RoutesName.whatsappScreen);
        break;
      case 8:
        Navigator.pushNamed(context, RoutesName.emailScreen);
        break;
      case 9:
        Navigator.pushNamed(context, RoutesName.twitterScreen);
        break;
      case 10:
        Navigator.pushNamed(context, RoutesName.instagramScreen);
        break;
      case 11:
        Navigator.pushNamed(context, RoutesName.phoneScreen);
        break;
    }
  }
}
