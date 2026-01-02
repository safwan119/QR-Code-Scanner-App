import '../view/views.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.firstScreen:
        return MaterialPageRoute(builder: (context) => FirstScreen());
      case RoutesName.secondScreen:
        return MaterialPageRoute(builder: (context) => SecondScreen());
      case RoutesName.thirdScreen:
        return MaterialPageRoute(builder: (context) => ThirdScreen());
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
      case RoutesName.settingScreen:
        return MaterialPageRoute(builder: (context) => QrCodeSetting());
      case RoutesName.phoneScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForPhone());
      case RoutesName.historyScreen:
        return MaterialPageRoute(builder: (context) => QrCodeHistory());
      case RoutesName.generateScreen:
        return MaterialPageRoute(builder: (context) => GenerateQrCode());
      case RoutesName.emailScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForEmail());
      case RoutesName.eventScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForEvent());
      case RoutesName.whatsappScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWhatsapp());
      case RoutesName.instagramScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForInstagram());
      case RoutesName.twitterScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForTwitter());
      case RoutesName.textScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForText());
      case RoutesName.wifiScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWifi());
      case RoutesName.locationScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForLocation());
      case RoutesName.websiteScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForWebsite());
      case RoutesName.businessScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForBusiness());
      case RoutesName.contactScreen:
        return MaterialPageRoute(builder: (context) => QrCodeForContact());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.bottomNavigationScreen:
        return MaterialPageRoute(builder: (context) => BottomNavigation());
      case RoutesName.resultScreen:
        final String qrData = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) => QrCodeResult(qrData: qrData),
        );
      case RoutesName.qrCodeScreen:
        final String qrData = setting.arguments as String;
        return MaterialPageRoute(builder: (context) => QRCode(qrData: qrData));

      default:
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text("NO Routes Find"))),
        );
    }
  }
}
