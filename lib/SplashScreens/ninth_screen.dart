import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class NinthScreen extends StatefulWidget {
  const NinthScreen({super.key});

  @override
  State<NinthScreen> createState() => _NinthScreenState();
}

class _NinthScreenState extends State<NinthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/CurveBackgroundImage.png"),
              Image.asset("assets/images/QRCodeImage.png"),
              SizedBox(height: MediaQuery.of(context).size.height * .08),
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
                  color: Colors.black,
                  isColor: true,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.tenthScreen);
                },
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset("assets/images/blackLetsStart.png"),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Image.asset("assets/images/arrow-right.png"),
                    ),
                  ],
                ),
              ),
              Image.asset("assets/images/Curve2Image.png"),
            ],
          ),
        ),
      ),
    );
  }
}
