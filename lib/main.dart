import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/route/routes.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import 'package:qr_code_scanner/state/camera_control_provider.dart';
import 'package:qr_code_scanner/state/device_id_provider.dart';
import 'package:qr_code_scanner/state/gallery_image_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("e4fdd5b1-c113-4d15-b13b-a8c9eab021f2");
  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CameraControlProvider(),),
        ChangeNotifierProvider(create: (context)=>DeviceIdProvider()),
        ChangeNotifierProvider(create: (context)=>GalleryImageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Swift',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: RoutesName.eleventhScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
