import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppSize.getHeight(24.0)),
              Center(child: Image.asset("assets/images/QRCodeImage.png")),

              SizedBox(height: AppSize.getHeight(24.0)),
              Text(
                "Go and enjoy our features for free and\n make your life easy with us.",
                textAlign: TextAlign.center,
                style: textStyle(
                  fontSize: 18,
                  isColor: true,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: AppSize.h3),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.fifthScreen);
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset("assets/images/blackLetsStart.png"),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Image.asset("assets/images/arrow-right.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
