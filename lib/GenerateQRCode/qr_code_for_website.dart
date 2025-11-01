import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';

class QrCodeForWebsite extends StatefulWidget {
  const QrCodeForWebsite({super.key});

  @override
  State<QrCodeForWebsite> createState() => _QrCodeForWebsiteState();
}

class _QrCodeForWebsiteState extends State<QrCodeForWebsite> {
  void generateQrCode(){
    final websiteUrlLink=Controllers.websiteUrl;
    if(Controllers.websiteUrl.isEmpty){
     ShortMessage.showErrorMessage("Please enter the website url");
      return;
    }
    final qrData=websiteUrlLink;
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
                "Website",
                style:textStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Website Url",
              onTap: generateQrCode,
              image: "assets/images/WebsiteIcon.png",
              controller: Controllers.urlController,
              hintText: "Enter www.qrcode.com"
          )
        ],
      ),
    );
  }
}
