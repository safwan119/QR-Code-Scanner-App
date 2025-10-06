import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
class QrCodeForWhatsapp extends StatefulWidget {
  const QrCodeForWhatsapp({super.key});

  @override
  State<QrCodeForWhatsapp> createState() => _QrCodeForWhatsappState();
}

class _QrCodeForWhatsappState extends State<QrCodeForWhatsapp> {
  final whatsappNumberController=TextEditingController();
  void generateQrCode(){
    var whatsappNumber=whatsappNumberController.text.trim();
    final input="http://wa.me/$whatsappNumber";
    if(whatsappNumber.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please enter your whatsapp number")));
      return;
    }
    if (whatsappNumber.startsWith('+')) {
      whatsappNumber = whatsappNumber.substring(1);
    }
    if (whatsappNumber.startsWith('0')) {
      whatsappNumber = '92${whatsappNumber.substring(1)}';
    }
    whatsappNumber = whatsappNumber.replaceAll(RegExp(r'[^\d]'), '');
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
                "Whatsapp",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Whatsapp Number",
              onTap:generateQrCode,
              image: "assets/images/WhatsappIcon.png",
              controller: whatsappNumberController,
              hintText: "Enter number"
          )
        ],
      ),
    );
  }
}
