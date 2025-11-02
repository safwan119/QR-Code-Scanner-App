import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/ReusableWidget/generate_qr_code_using_channel.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/location_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../constants/controllers.dart';

class QrCodeForLocation extends StatefulWidget {
  const QrCodeForLocation({super.key});

  @override
  State<QrCodeForLocation> createState() => _QrCodeForLocationState();
}

class _QrCodeForLocationState extends State<QrCodeForLocation> {
  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();
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
              Text("Location", style: textStyle(fontSize: 22)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .13),
          GenerateQRCodeUsingChannel(
            title: "Location Name",
            validator: Validation.textValidation("Location"),
            onTap: locationController.generateLocationQr,
            image: "assets/images/LocationIcon.png",
            controller: Controllers.locationNameController,
            hintText: "Enter location name",
          ),
        ],
      ),
    );
  }
}
