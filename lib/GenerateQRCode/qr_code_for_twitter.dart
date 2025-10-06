import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';

class QrCodeForTwitter extends StatefulWidget {
  const QrCodeForTwitter({super.key});

  @override
  State<QrCodeForTwitter> createState() => _QrCodeForTwitterState();
}

class _QrCodeForTwitterState extends State<QrCodeForTwitter> {
  final userNameController = TextEditingController();
  void generateQrCode(){
    final twitterUserName=userNameController.text.trim();
    final input="https://twitter.com/$twitterUserName";
    if(twitterUserName.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please enter the user name of twitter")));
      return;
    }
    final qrData=input;
    SaveQrCode saveQrCode=SaveQrCode();
    saveQrCode.saveQrCodeData(qrData);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCode(qrData)));
  }

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
              onTap:generateQrCode,
              image: "assets/images/TwitterIcon.png",
              controller: userNameController,
              hintText: "Enter twitter username"
          )
        ],
      ),
    );
  }
}
