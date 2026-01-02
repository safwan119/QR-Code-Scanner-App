import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/ReusableWidget/splash_screen_widget.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

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
      Navigator.pushNamed(context, RoutesName.secondScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenWidget(
        image: "assets/images/blackPic.png",
        bgColor: Colors.black87,
      ),
    );
  }
}
