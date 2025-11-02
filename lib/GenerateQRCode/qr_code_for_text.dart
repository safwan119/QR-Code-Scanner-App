import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/text_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
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

  @override
  Widget build(BuildContext context) {
    final textController = Get.find<TextController>();
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
              Text("Text", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Text",
            validator: Validation.textValidation("text"),
            onTap: textController.textGenerateQrCode,
            image: "assets/images/TextIcon.png",
            controller: Controllers.textController,
            hintText: "Enter text",
          ),
        ],
      ),
    );
  }
}
