import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';
class QrCodeForWhatsapp extends StatefulWidget {
  const QrCodeForWhatsapp({super.key});

  @override
  State<QrCodeForWhatsapp> createState() => _QrCodeForWhatsappState();
}

class _QrCodeForWhatsappState extends State<QrCodeForWhatsapp> {
  void generateQrCode(){
    var whatsappNumber=Controllers.whatsappNumberController.text.trim();
    final input="http://wa.me/$whatsappNumber";
    if(whatsappNumber.isEmpty){
     ShortMessage.showErrorMessage("Please enter your whatsapp number");
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
    Get.toNamed(RoutesName.qrCodeScreen,arguments: qrData);
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
                  Get.back();
                },
                child: Image.asset(ImagePath.arrowBackImage),
              ),
              Text(
                "Whatsapp",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Whatsapp Number",
              onTap:generateQrCode,
              image: "assets/images/WhatsappIcon.png",
              controller: Controllers.whatsappNumberController,
              hintText: "Enter number"
          )
        ],
      ),
    );
  }
}
