import 'package:flutter/material.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_wifi.dart';
import 'package:qr_code_scanner/SplashScreens/first_screen.dart';
import 'BottomNavigationBar/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:QrCodeForWifi(),
    );
  }
}
