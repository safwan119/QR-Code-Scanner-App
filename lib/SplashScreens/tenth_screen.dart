import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class TenthScreen extends StatelessWidget {
  const TenthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/IntersectImage.png"),
              SizedBox(height: AppSize.h6),
              Image.asset("assets/images/QRCodeImage.png"),
              SizedBox(height: AppSize.getHeight(15.0)),
              Text(
                "Get Started",
                style: textStyle(
                  fontSize: 30,
                  isColor: true,
                  color: Colors.black,
                ),
              ),
              Text(
                "Go and enjoy our features for free and\n make your life easy with us.",
                textAlign: TextAlign.center,
                style: textStyle(
                  fontSize: 18,
                  isColor: true,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: AppSize.h4),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Image.asset("assets/images/CurveLowerImage.png"),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.eleventhScreen);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.amber.shade600,
                        radius: 35,
                        foregroundColor: Colors.amber,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
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
