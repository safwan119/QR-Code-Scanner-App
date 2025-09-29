import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/ReusableWidget/splash_screen_widget.dart';
import 'package:qr_code_scanner/SplashScreens/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SplashScreenWidget(
        image: "assets/images/FirstQRCodePic.png",
        bgColor: Colors.black,
      ),
    );
  }
}
