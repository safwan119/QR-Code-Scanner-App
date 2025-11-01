import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code_scanner/core/binding/initial_binding.dart';
import 'package:qr_code_scanner/res/getx_localization/language.dart';
import 'package:qr_code_scanner/route/app_pages.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("e4fdd5b1-c113-4d15-b13b-a8c9eab021f2");
  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Swift',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialBinding: InitialBinding(),
        locale: Locale("en","US"),
        fallbackLocale: Locale("en","US"),
        translations: Language(),
        initialRoute: RoutesName.eleventhScreen,
        getPages:AppPages.Routes,
      );

  }
}
