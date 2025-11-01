import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';

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
      ShortMessage.showErrorMessage("Please fill email address");
      return;
    }
    final qrData=emailInput;
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
