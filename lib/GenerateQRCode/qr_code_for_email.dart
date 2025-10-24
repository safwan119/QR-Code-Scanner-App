import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';

class QrCodeForEmail extends StatefulWidget {
  const QrCodeForEmail({super.key});

  @override
  State<QrCodeForEmail> createState() => _QrCodeForEmailState();
}

class _QrCodeForEmailState extends State<QrCodeForEmail> {
  @override
  void dispose() {
    Controllers.emailController.dispose();
    super.dispose();
  }
  void generateQrCode(){
    final emailInput="mailto:${Controllers.emailAddress}";
    if(Controllers.emailAddress.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please enter email address")));
      return;
    }
    final qrData=emailInput;
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
                "Email",
                style:textStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Email",
              onTap:generateQrCode,
              image: "assets/images/EmailIcon.png",
              controller:Controllers.emailController,
              hintText: "Enter email address"
          )
        ],
      ),
    );
  }
}
