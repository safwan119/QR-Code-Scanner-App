import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_bloc.dart';
import 'package:qr_code_scanner/bloc/gallery_image/gallery_image_bloc.dart';
import 'package:qr_code_scanner/bloc/preference/preference_bloc.dart';
import 'package:qr_code_scanner/route/routes.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
import 'firebase_options.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PreferenceBloc()),
        BlocProvider(create: (context) => GalleryImageBloc()),
        BlocProvider(create: (context) => ChangeCameraBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Swift',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        locale: Locale("en", "US"),
        initialRoute: RoutesName.firstScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
