import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';
class QrCodeForWhatsapp extends StatefulWidget {
  const QrCodeForWhatsapp({super.key});

  @override
  State<QrCodeForWhatsapp> createState() => _QrCodeForWhatsappState();
}

class _QrCodeForWhatsappState extends State<QrCodeForWhatsapp> {
  final whatsappNumberController=TextEditingController();
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
              onTap: (){
              },
              image: "assets/images/WhatsappIcon.png",
              controller: whatsappNumberController,
              hintText: "Enter number"
          )
        ],
      ),
    );
  }
}
