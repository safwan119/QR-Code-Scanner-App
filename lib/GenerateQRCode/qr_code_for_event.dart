import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';
import 'package:qr_code_scanner/constants/qr_code_outputs.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_button.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';
import '../route/routes_name.dart';

class QrCodeForEvent extends StatefulWidget {
  const QrCodeForEvent({super.key});

  @override
  State<QrCodeForEvent> createState() => _QrCodeForEventState();
}

class _QrCodeForEventState extends State<QrCodeForEvent> {
 @override
  void dispose() {
   Controllers.eventNameController.dispose();
   Controllers.startDateTimeController.dispose();
   Controllers.endDateTimeController.dispose();
   Controllers.eventLocationController.dispose();
    super.dispose();
  }
  void generateQrCode() {
    if (Controllers.eventName.isEmpty ||
        Controllers.startDateTime.isEmpty ||
        Controllers.endDateTime.isEmpty ||
        Controllers.eventLocation.isEmpty) {
      ShortMessage.showErrorMessage("Please fill all fields for generating qr code");
      return;
    }
    final qrData=QrCodeOutputs.eventDetailOutput;
    SaveQrCode saveQrCode=SaveQrCode();
    saveQrCode.saveQrCodeData(qrData);
    Get.toNamed(RoutesName.qrCodeScreen,arguments: qrData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
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
                  "Event",
                  style:textStyle(fontSize: 22)
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    top: BorderSide(color: Colors.amber.shade600),
                    bottom: BorderSide(color: Colors.amber.shade600),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Center(child: Image.asset("assets/images/EventIcon.png")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Event Name",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.eventNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter event name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Start Date and Time",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.startDateTimeController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "12 Dec 2022, 10:40 pm",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "End Date and Time",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.endDateTimeController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "12 Dec 2022, 10:40 pm",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Event Location",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.eventLocationController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter location",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.descriptionController,
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter any details",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      GenerateButton(title: "Generate QR Code", onTap:generateQrCode),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .09),
          ],
        ),
      ),
    );
  }
}
