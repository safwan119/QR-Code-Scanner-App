import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/SplashScreens/fifth_screen.dart';

import '../ReusableWidget/rounded_button.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({super.key});

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: ClipRRect(
                  child: Image.asset("assets/images/QRCodeImage.png"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .30),
              Text(
                "Go and enjoy our features for free and\n make your life easy with us.",
                textAlign: TextAlign.center,
                style: GoogleFonts.akayaTelivigala(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 18
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: RoundedButton(
                  title: "Let's Start",
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>FifthScreen()));
                  },
                  bgColor: Colors.black,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
