import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';

class QrCodeForWebsite extends StatefulWidget {
  const QrCodeForWebsite({super.key});

  @override
  State<QrCodeForWebsite> createState() => _QrCodeForWebsiteState();
}

class _QrCodeForWebsiteState extends State<QrCodeForWebsite> {
  final urlController = TextEditingController();

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
                "Website",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Website Url",
              onTap: (){
              },
              image: "assets/images/WebsiteIcon.png",
              controller: urlController,
              hintText: "Enter www.qrcode.com"
          )
        ],
      ),
    );
  }
}
