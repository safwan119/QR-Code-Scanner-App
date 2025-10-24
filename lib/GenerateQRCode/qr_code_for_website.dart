import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';

class QrCodeForWebsite extends StatefulWidget {
  const QrCodeForWebsite({super.key});

  @override
  State<QrCodeForWebsite> createState() => _QrCodeForWebsiteState();
}

class _QrCodeForWebsiteState extends State<QrCodeForWebsite> {
  void generateQrCode(){
    final websiteUrlLink=Controllers.websiteUrl;
    if(Controllers.websiteUrl.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please enter the website url")));
      return;
    }
    final qrData=websiteUrlLink;
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
                "Website",
                style:textStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Website Url",
              onTap: generateQrCode,
              image: "assets/images/WebsiteIcon.png",
              controller: Controllers.urlController,
              hintText: "Enter www.qrcode.com"
          )
        ],
      ),
    );
  }
}
