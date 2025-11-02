import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/phone_number_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../constants/controllers.dart';

class QrCodeForPhone extends StatefulWidget {
  const QrCodeForPhone({super.key});

  @override
  State<QrCodeForPhone> createState() => _QrCodeForPhoneState();
}

class _QrCodeForPhoneState extends State<QrCodeForPhone> {
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
              Text("Phone", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Phone Number",
            validator: Validation.phoneNumberValidity("Phone Number"),
            onTap: numberController.generatePhoneNumberQr,
            image: "assets/images/PhoneIcon.png",
            controller: Controllers.phoneController,
            hintText: "+92xxxxxxxxx",
          ),
        ],
      ),
    );
  }
}
