import 'package:url_launcher/url_launcher.dart';

import '../../view/views.dart';

class PhoneNumberLaunching {
  static String formatePhoneNumber({required String phoneNumber}) {
    phoneNumber = phoneNumber.replaceAll(' ', '');
    if (phoneNumber.startsWith("+")) {
      return phoneNumber.substring(1);
    } else if (phoneNumber.startsWith("0")) {
      return "92${phoneNumber.substring(1)}";
    } else {
      return phoneNumber;
    }
  }

  static Future<void> LaunchPhoneNumber(String phoneNumber) async {
    try {
      final formatedPhoneNumber = formatePhoneNumber(
        phoneNumber: phoneNumber,
      );
      final url = Uri.parse("https://wa.me/$formatedPhoneNumber");
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Can't lunch whatsapp or url ==>$url");
        throw Exception('Cannot open whatsapp url');
      }
    } catch (e) {
      debugPrint("Error during launching url $e");
    }
  }

  static Future<void> launchToDialer(String phoneNumber) async {
    try {
      phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
      final Uri url = Uri(scheme: "tel", path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Error during launching the url==>$url");
      }
    } catch (e) {
      debugPrint("The error during launching url=>$e");
    }
  }
}
