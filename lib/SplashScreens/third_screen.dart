import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .25),
            Center(child: Image.asset("assets/images/blackPic.png")),
            SizedBox(height: MediaQuery.of(context).size.height * .22),
            Text(
              "Go and enjoy our features for free and\n make your life easy with us.",
              textAlign: TextAlign.center,
              style: textStyle(fontSize: 18),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .04),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.fourthScreen);
              },
              child: Image.asset("assets/images/amberLetsStart.png"),
            ),
          ],
        ),
      ),
    );
  }
}
