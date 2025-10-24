import 'package:flutter/material.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_business.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_contact.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_email.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_event.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_location.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_text.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_twitter.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_website.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_whatsapp.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_wifi.dart';
import 'package:qr_code_scanner/HomeScreen/home_screen.dart';
import 'package:qr_code_scanner/QRCodeGenerate/generate_qr_code.dart';
import 'package:qr_code_scanner/QRCodesHistory/qr_code_history.dart';
import 'package:qr_code_scanner/Setting/qr_code_setting.dart';
import 'package:qr_code_scanner/SplashScreens/eighth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/eleventh_screen.dart';
import 'package:qr_code_scanner/SplashScreens/fifth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/first_screen.dart';
import 'package:qr_code_scanner/SplashScreens/fourth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/ninth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/seventh_screen.dart';
import 'package:qr_code_scanner/SplashScreens/sixth_screen.dart';
import 'package:qr_code_scanner/SplashScreens/tenth_screen.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../BottomNavigationBar/bottom_navigation_bar.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.firstScreen:
        return MaterialPageRoute(builder: (context) => FirstScreen());
      case RoutesName.fourthScreen:
        return MaterialPageRoute(builder: (context) => FourthScreen());
      case RoutesName.fifthScreen:
        return MaterialPageRoute(builder: (context) => FifthScreen());
      case RoutesName.sixthScreen:
        return MaterialPageRoute(builder: (context) => SixthScreen());
      case RoutesName.seventhScreen:
        return MaterialPageRoute(builder: (context) => SeventhScreen());
      case RoutesName.eighthScreen:
        return MaterialPageRoute(builder: (context) => EighthScreen());
      case RoutesName.ninthScreen:
        return MaterialPageRoute(builder: (context) => NinthScreen());
      case RoutesName.tenthScreen:
        return MaterialPageRoute(builder: (context) => TenthScreen());
      case RoutesName.eleventhScreen:
        return MaterialPageRoute(builder: (context) => EleventhScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.businessScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForBusiness());
      case RoutesName.contactScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForContact());
      case RoutesName.textScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForText());
      case RoutesName.locationScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForLocation());
      case RoutesName.wifiScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWifi());
      case RoutesName.whatsappScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWhatsapp());
      case RoutesName.twitterScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForTwitter());
      case RoutesName.websiteScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWebsite());
      case RoutesName.emailScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForEmail());
      case RoutesName.eventScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForEvent());
      case RoutesName.generateScreen:
        return MaterialPageRoute(builder: (context) => GenerateQrCode());
      case RoutesName.historyScreen:
        return MaterialPageRoute(builder: (context) => QrCodeHistory());
      case RoutesName.settingScreen:
        return MaterialPageRoute(builder: (context) => QrCodeSetting());
      case RoutesName.bottomNavigationScreen:
        return MaterialPageRoute(builder: (context) => BottomNavigation());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(body: Text("No page Route defined"));
          },
        );
    }
  }
}
