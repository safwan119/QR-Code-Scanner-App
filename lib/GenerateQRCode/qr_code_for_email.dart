import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/email_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../constants/controllers.dart';

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

  @override
  Widget build(BuildContext context) {
    final emailController = Get.find<EmailController>();
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
              Text("Email", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Email",
            validator: Validation.emailValidity("Email"),
            onTap: emailController.GenerateEmailQr,
            image: "assets/images/EmailIcon.png",
            controller: Controllers.emailController,
            hintText: "Enter email address",
          ),
        ],
      ),
    );
  }
}
