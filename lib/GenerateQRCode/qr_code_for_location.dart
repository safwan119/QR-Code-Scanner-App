import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';
class QrCodeForLocation extends StatefulWidget {
  const QrCodeForLocation({super.key});

  @override
  State<QrCodeForLocation> createState() => _QrCodeForLocationState();
}

class _QrCodeForLocationState extends State<QrCodeForLocation> {
  void generateQrCode(){
    final encodedLocation=Uri.encodeComponent(Controllers.whatsappNumber);
    final input="https://www.google.com/maps/search/?api=1&query=$encodedLocation";
    if(Controllers.whatsappNumber.isEmpty){
     ShortMessage.showErrorMessage("Please enter your location name");
      return;
    }
    final qrData=input;
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
                "Location",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(title: "Location Name",
              onTap:generateQrCode,
              image: "assets/images/LocationIcon.png",
              controller: Controllers.locationNameController,
              hintText: "Enter location name"
          )
        ],
      ),
    );
  }
}
