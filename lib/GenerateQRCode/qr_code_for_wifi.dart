import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ReusableWidget/generate_button.dart';

class QrCodeForWifi extends StatefulWidget {
  const QrCodeForWifi({super.key});

  @override
  State<QrCodeForWifi> createState() => _QrCodeForWifiState();
}

class _QrCodeForWifiState extends State<QrCodeForWifi> {
  final networkNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/images/ArrowBackPic.png"),
              ),
              Text(
                "Wi-Fi",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  top: BorderSide(color: Colors.amber.shade600),
                  bottom: BorderSide(color: Colors.amber.shade600),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Center(child: Image.asset("assets/images/WifiIcon.png")),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Network",
                        style: GoogleFonts.akayaTelivigala(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: networkNameController,
                      decoration: InputDecoration(
                        hintText: "Enter network name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: GoogleFonts.akayaTelivigala(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    GenerateButton(title: "Generate QR Code", onTap: () {}),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
