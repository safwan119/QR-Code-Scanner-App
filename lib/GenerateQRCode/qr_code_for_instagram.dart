import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';

class QrCodeForInstagram extends StatefulWidget {
  const QrCodeForInstagram({super.key});

  @override
  State<QrCodeForInstagram> createState() => _QrCodeForInstagramState();
}

class _QrCodeForInstagramState extends State<QrCodeForInstagram> {
  @override
  void dispose() {
    Controllers.userNameController.dispose();
    super.dispose();
  }
  void generateQrCode(){
    final instagramUrl="https://www.instagram.com/${Controllers.userName}";
    if(Controllers.userName.isEmpty){
     ShortMessage.showErrorMessage("Please enter the username of instagram account");
      return;
    }
    final qrData=instagramUrl;
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
                "Instagram",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Username",
              onTap:generateQrCode,
              image: "assets/images/InstagramIcon.png",
              controller: Controllers.userNameController,
              hintText: "Enter instagram username"
          )
        ],
      ),
    );
  }
}
