import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_business.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_contact.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_email.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_event.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_instagram.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_location.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_phone.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_text.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_twitter.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_website.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_whatsapp.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_wifi.dart';
import 'package:qr_code_scanner/HomeScreen/home_screen.dart';
import 'package:qr_code_scanner/QRCodeGenerate/generate_qr_code.dart';
import 'package:qr_code_scanner/QRCodesHistory/qr_code_history.dart';
import 'package:qr_code_scanner/Result/qr_code_result.dart';
import 'package:qr_code_scanner/Setting/qr_code_setting.dart';
import 'package:qr_code_scanner/SplashScreens/eighth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/eleventh_screen.dart';
import 'package:qr_code_scanner/SplashScreens/fifth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/first_screen.dart';
import 'package:qr_code_scanner/SplashScreens/fourth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/ninth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/second_screen.dart';
import 'package:qr_code_scanner/SplashScreens/seventh_screen.dart';
import 'package:qr_code_scanner/SplashScreens/sixth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/tenth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/third_screen.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:get/get.dart';

import '../Result/QRCodeData/q_r_code.dart';

class AppPages {
  static final Routes = [
    GetPage(name: RoutesName.firstScreen, page: () => FirstScreen()),
    GetPage(name: RoutesName.secondScreen, page: () => SecondScreen()),
    GetPage(name: RoutesName.thirdScreen, page: () => ThirdScreen()),
    GetPage(name: RoutesName.fourthScreen, page: () => FourthScreen()),
    GetPage(name: RoutesName.fifthScreen, page: () => FifthScreen()),
    GetPage(name: RoutesName.sixthScreen, page: () => SixthScreen()),
    GetPage(name: RoutesName.seventhScreen, page: () => SeventhScreen()),
    GetPage(name: RoutesName.eighthScreen, page: () => EighthScreen()),
    GetPage(name: RoutesName.ninthScreen, page: () => NinthScreen()),
    GetPage(name: RoutesName.tenthScreen, page: () => TenthScreen()),
    GetPage(name: RoutesName.eleventhScreen, page: () => EleventhScreen()),
    GetPage(name: RoutesName.settingScreen, page: () => QrCodeSetting()),
    GetPage(name: RoutesName.phoneScreen, page: () => QrCodeForPhone()),
    GetPage(name: RoutesName.historyScreen, page: () => QrCodeHistory()),
    GetPage(name: RoutesName.generateScreen, page: () => GenerateQrCode()),
    GetPage(name: RoutesName.emailScreen, page: () => QrCodeForEmail()),
    GetPage(name: RoutesName.eventScreen, page: () => QrCodeForEvent()),
    GetPage(name: RoutesName.whatsappScreen, page: () => QrCodeForWhatsapp()),
    GetPage(name: RoutesName.instagramScreen, page: () => QrCodeForInstagram()),
    GetPage(name: RoutesName.twitterScreen, page: () => QrCodeForTwitter()),
    GetPage(name: RoutesName.textScreen, page: () => QrCodeForText()),
    GetPage(name: RoutesName.wifiScreen, page: () => QrCodeForWifi()),
    GetPage(name: RoutesName.locationScreen, page: () => QrCodeForLocation()),
    GetPage(name: RoutesName.websiteScreen, page: () => QrCodeForWebsite()),
    GetPage(name: RoutesName.businessScreen, page: () => QrCodeForBusiness()),
    GetPage(name: RoutesName.contactScreen, page: () => QrCodeForContact()),
    GetPage(name: RoutesName.homeScreen, page: () => HomeScreen()),
    GetPage(
      name: RoutesName.bottomNavigationScreen,
      page: () => BottomNavigation(),
    ),
    GetPage(
      name: RoutesName.resultScreen,
      page: () => QrCodeResult(),
    ),
    GetPage(
      name: RoutesName.qrCodeScreen,
      page: () => QRCode(),
    ),
  ];
}
