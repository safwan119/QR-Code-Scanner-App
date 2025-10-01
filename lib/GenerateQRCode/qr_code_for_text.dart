import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
class QrCodeForText extends StatefulWidget {
  const QrCodeForText({super.key});

  @override
  State<QrCodeForText> createState() => _QrCodeForTextState();
}

class _QrCodeForTextState extends State<QrCodeForText> {
  final textController = TextEditingController();

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
                "Text",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Text",
              onTap: (){
              },
              image: "assets/images/TextIcon.png",
              controller: textController,
              hintText: "Enter text"
          )
        ],
      ),
    );
  }
}
