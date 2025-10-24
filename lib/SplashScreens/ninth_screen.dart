import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/SplashScreens/tenth_screen.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

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
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                ),
              ),
              Text(
                "Go and enjoy our features for free and\n make your life easy with us.",
                textAlign: TextAlign.center,
                style: textStyle(fontSize: 18,color: Colors.black,isColor: true)
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TenthScreen()),
                  );
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
