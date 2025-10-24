import 'package:flutter/material.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../constants/text_style.dart';
class QrCodeForText extends StatefulWidget {
  const QrCodeForText({super.key});

  @override
  State<QrCodeForText> createState() => _QrCodeForTextState();
}

class _QrCodeForTextState extends State<QrCodeForText> {
  @override
  void dispose() {
    Controllers.textController.dispose();
    super.dispose();
  }
  void generateQrCode() {
    if (Controllers.textName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter some text to generate the QR code."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    final qrData =Controllers.textName;
    SaveQrCode saveQrCode=SaveQrCode();
    saveQrCode.saveQrCodeData(qrData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCode(qrData),
      ),
    );
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
                "Text",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Text",
              onTap: generateQrCode,
              image: "assets/images/TextIcon.png",
              controller: Controllers.textController,
              hintText: "Enter text"
          )
        ],
      ),
    );
  }
}
