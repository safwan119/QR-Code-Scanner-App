import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../constants/text_style.dart';
import '../route/routes_name.dart';
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
  void generateQrCode() {
    if (Controllers.textName.isEmpty) {
      ShortMessage.showErrorMessage("Please enter some text to generate the QR code.");
      return;
    }
    final qrData =Controllers.textName;
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
                "Text",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Text",
              onTap: generateQrCode,
              image: "assets/images/TextIcon.png",
              controller: Controllers.textController,
              hintText: "Enter text"
          )
        ],
      ),
    );
  }
}
