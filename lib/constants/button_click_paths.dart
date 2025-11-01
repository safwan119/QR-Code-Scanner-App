import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class ButtonClickPaths {
  static buttonClick(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.toNamed(RoutesName.textScreen);
        break;
      case 1:
        Get.toNamed(RoutesName.websiteScreen);
        break;
      case 2:
        Get.toNamed(RoutesName.wifiScreen);
        break;
      case 3:
        Get.toNamed(RoutesName.eventScreen);
        break;
      case 4:
        Get.toNamed(RoutesName.contactScreen);
        break;
      case 5:
        Get.toNamed(RoutesName.businessScreen);
        break;
      case 6:
        Get.toNamed(RoutesName.locationScreen);
        break;
      case 7:
        Get.toNamed(RoutesName.whatsappScreen);
        break;
      case 8:
        Get.toNamed(RoutesName.emailScreen);
        break;
      case 9:
        Get.toNamed(RoutesName.twitterScreen);
        break;
      case 10:
        Get.toNamed(RoutesName.instagramScreen);
        break;
      case 11:
        Get.toNamed(RoutesName.phoneScreen);
        break;
    }
  }
}
