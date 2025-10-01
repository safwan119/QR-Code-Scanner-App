import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';

class QrCodeForEmail extends StatefulWidget {
  const QrCodeForEmail({super.key});

  @override
  State<QrCodeForEmail> createState() => _QrCodeForEmailState();
}

class _QrCodeForEmailState extends State<QrCodeForEmail> {
  final emailController = TextEditingController();

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
                "Email",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Email",
              onTap: (){
              },
              image: "assets/images/EmailIcon.png",
              controller:emailController,
              hintText: "Enter email address"
          )
        ],
      ),
    );
  }
}
