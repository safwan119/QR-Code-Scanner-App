import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/constants/launch_qr_data.dart';
import 'package:qr_code_scanner/constants/shared_apk_and_qr_data.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/route/routes_name.dart';
class QrCodeResult extends StatelessWidget {
  final String qrData=Get.arguments;
   QrCodeResult({super.key});
  late final String shareMessage = 'Qr Code data is: $qrData';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Row(
            children: [
              InkWell(onTap: (){
                Get.back();
              },
                  child: Image.asset(ImagePath.arrowBackImage)),
              Text(
                "Result",
                style:textStyle(fontSize: 22)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(ImagePath.qrCodeDataImage),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Data",
                              style:textStyle(fontSize: 22)
                            ),
                            Text(
                              DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.now()),
                              style:textStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.white10, thickness: 3),
                    SelectableText(onTap: () {
                      LaunchQrData.launchQrData(context,qrData);
                    },
                      selectionColor: Colors.blue,
                      minLines: 1,
                      qrData,
                      style:textStyle(fontSize: 16),
                      maxLines: 5,
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                       Get.toNamed(RoutesName.qrCodeScreen,arguments: qrData);
                      },
                      child: Text(
                        "Show QR Code",
                        style:textStyle(fontSize: 16,isColor: true,color: Colors.amber.shade600)
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(onTap:(){
                    SharedApkAndQrData.shareQrDataAsText(qrData);
                  },
                      child: Image.asset("assets/images/SharePic.png")),
                  const SizedBox(height: 4),
                  Text(
                    "Share",
                    style:textStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(onTap: (){
                    SharedApkAndQrData.copyQrDataToClipboard(qrData);
                  },
                      child: Image.asset("assets/images/CopyPic.png")),
                  SizedBox(height: 4),
                  Text(
                    "Copy",
                    style:textStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
