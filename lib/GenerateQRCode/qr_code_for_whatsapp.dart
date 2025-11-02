import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/phone_number_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../constants/controllers.dart';

class QrCodeForWhatsapp extends StatefulWidget {
  const QrCodeForWhatsapp({super.key});

  @override
  State<QrCodeForWhatsapp> createState() => _QrCodeForWhatsappState();
}

class _QrCodeForWhatsappState extends State<QrCodeForWhatsapp> {
  @override
  Widget build(BuildContext context) {
    final numberController = Get.find<PhoneNumberController>();
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
              Text("Whatsapp", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Whatsapp Number",
            validator: Validation.phoneNumberValidity("Whatsapp number"),
            onTap: numberController.generateWhatsappNumberQr,
            image: "assets/images/WhatsappIcon.png",
            controller: Controllers.whatsappNumberController,
            hintText: "Enter number",
          ),
        ],
      ),
    );
  }
}
