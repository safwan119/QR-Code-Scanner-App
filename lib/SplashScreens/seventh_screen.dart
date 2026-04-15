import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class SeventhScreen extends StatelessWidget {
  const SeventhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppSize.getHeight(30.0)),
              Center(child: Image.asset("assets/images/QRCodeImage.png")),
              SizedBox(height: AppSize.getHeight(15.0)),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/BackgroundImage.png",
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 34,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.eighthScreen);
                      },
                      child: Image.asset("assets/images/amberLetsStart.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
