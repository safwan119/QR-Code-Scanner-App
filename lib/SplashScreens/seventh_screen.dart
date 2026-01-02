import 'package:flutter/material.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class SeventhScreen extends StatefulWidget {
  const SeventhScreen({super.key});

  @override
  State<SeventhScreen> createState() => _SeventhScreenState();
}

class _SeventhScreenState extends State<SeventhScreen> {
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
              SizedBox(height: MediaQuery.of(context).size.height * .30),
              Center(child: Image.asset("assets/images/QRCodeImage.png")),
              SizedBox(height: MediaQuery.of(context).size.height * .15),
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
