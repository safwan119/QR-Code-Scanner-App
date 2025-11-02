import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/website_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../constants/controllers.dart';

class QrCodeForWebsite extends StatefulWidget {
  const QrCodeForWebsite({super.key});

  @override
  State<QrCodeForWebsite> createState() => _QrCodeForWebsiteState();
}

class _QrCodeForWebsiteState extends State<QrCodeForWebsite> {
  // void generateQrCode(){
  //   final websiteUrlLink=Controllers.websiteUrl;
  //   if(Controllers.websiteUrl.isEmpty){
  //    ShortMessage.showErrorMessage("Please enter the website url");
  //     return;
  //   }
  //   final qrData=websiteUrlLink;
  //   SaveQrCode saveQrCode=SaveQrCode();
  //   saveQrCode.saveQrCodeData(qrData);
  //   Get.toNamed(RoutesName.qrCodeScreen,arguments: qrData);
  // }

  @override
  Widget build(BuildContext context) {
    final websiteUrlController = Get.find<WebSiteController>();
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
              Text("Website", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Website Url",
            onTap: websiteUrlController.generateWebsiteUrl,
            validator: Validation.websiteUrlValidity("website url"),
            image: "assets/images/WebsiteIcon.png",
            controller: Controllers.urlController,
            hintText: "Enter www.qrcode.com",
          ),
        ],
      ),
    );
  }
}
