import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';

class QrCodeForPhone extends StatefulWidget {
  const QrCodeForPhone({super.key});

  @override
  State<QrCodeForPhone> createState() => _QrCodeForPhoneState();
}

class _QrCodeForPhoneState extends State<QrCodeForPhone> {
  final phoneNumberController = TextEditingController();

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
                "Phone",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Phone Number",
              onTap: (){
              },
              image: "assets/images/PhoneIcon.png",
              controller: phoneNumberController,
              hintText: "+92xxxxxxxxx"
          )
        ],
      ),
    );
  }
}
