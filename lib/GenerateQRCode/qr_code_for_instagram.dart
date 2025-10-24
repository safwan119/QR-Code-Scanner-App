import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';

class QrCodeForInstagram extends StatefulWidget {
  const QrCodeForInstagram({super.key});

  @override
  State<QrCodeForInstagram> createState() => _QrCodeForInstagramState();
}

class _QrCodeForInstagramState extends State<QrCodeForInstagram> {
  @override
  void dispose() {
    Controllers.userNameController.dispose();
    super.dispose();
  }
  void generateQrCode(){
    final instagramUrl="https://www.instagram.com/${Controllers.userName}";
    if(Controllers.userName.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please enter username of instagram")));
      return;
    }
    final qrData=instagramUrl;
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
                "Instagram",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Username",
              onTap:generateQrCode,
              image: "assets/images/InstagramIcon.png",
              controller: Controllers.userNameController,
              hintText: "Enter instagram username"
          )
        ],
      ),
    );
  }
}
