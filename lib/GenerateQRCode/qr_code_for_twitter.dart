import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';

class QrCodeForTwitter extends StatefulWidget {
  const QrCodeForTwitter({super.key});

  @override
  State<QrCodeForTwitter> createState() => _QrCodeForTwitterState();
}

class _QrCodeForTwitterState extends State<QrCodeForTwitter> {
  final userNameController = TextEditingController();

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
                "Twitter",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Username",
              onTap: (){
              },
              image: "assets/images/TwitterIcon.png",
              controller: userNameController,
              hintText: "Enter twitter username"
          )
        ],
      ),
    );
  }
}
