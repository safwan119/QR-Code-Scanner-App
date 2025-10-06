import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';

class QrCodeForPhone extends StatefulWidget {
  const QrCodeForPhone({super.key});

  @override
  State<QrCodeForPhone> createState() => _QrCodeForPhoneState();
}

class _QrCodeForPhoneState extends State<QrCodeForPhone> {
  final phoneNumberController = TextEditingController();
  void generateQrCode(){
    final phoneNumber=phoneNumberController.text.trim();
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final input="tel:$cleanNumber";
    if(phoneNumber.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please your phone number")));
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
              onTap:generateQrCode,
              image: "assets/images/PhoneIcon.png",
              controller: phoneNumberController,
              hintText: "+92xxxxxxxxx"
          )
        ],
      ),
    );
  }
}
