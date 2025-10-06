import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/ReusableWidget/rounded_button.dart';
import 'package:qr_code_scanner/SplashScreens/fourth_screen.dart';

import '../SharedPreference/user_id_services.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .25),
            Center(
              child: Image.asset("assets/images/thirstScreenPic.png"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .25),
            Text(
              "Go and enjoy our features for free and\n make your life easy with us.",
              textAlign: TextAlign.center,
              style: GoogleFonts.akayaTelivigala(
                color: Colors.white,
                  fontWeight: FontWeight.w300,
                fontSize: 18
              ),),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RoundedButton(
                iconColor: Colors.black,
                textColor: Colors.black,
                title: "Let's Start",
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourthScreen()),
                  );
                },
                bgColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
