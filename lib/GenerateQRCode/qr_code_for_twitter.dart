import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/instagram_twitter_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../constants/controllers.dart';

class QrCodeForTwitter extends StatefulWidget {
  const QrCodeForTwitter({super.key});

  @override
  State<QrCodeForTwitter> createState() => _QrCodeForTwitterState();
}

class _QrCodeForTwitterState extends State<QrCodeForTwitter> {
  @override
  Widget build(BuildContext context) {
    final usernameController = Get.find<InstagramTwitterController>();
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
              Text("Twitter", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Username",
            onTap: usernameController.twitterUserQr,
            validator: Validation.usernameValidity("Twitter UserName"),
            image: "assets/images/TwitterIcon.png",
            controller: Controllers.twitterController,
            hintText: "Enter twitter username",
          ),
        ],
      ),
    );
  }
}
