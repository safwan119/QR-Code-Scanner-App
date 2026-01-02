import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/ReusableWidget/splash_screen_widget.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, RoutesName.eleventhScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenWidget(
        image: "assets/images/QRCodeImage.png",
        bgColor: Colors.amber.shade600,
      ),
    );
  }
}
