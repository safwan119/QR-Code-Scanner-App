import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../SharedPreference/user_id_services.dart';

class EleventhScreen extends StatefulWidget {
  const EleventhScreen({super.key});

  @override
  State<EleventhScreen> createState() => _EleventhScreenState();
}

class _EleventhScreenState extends State<EleventhScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSize.getHeight(28.0)),
            Center(child: Image.asset("assets/images/QRCodeImage.png")),
            SizedBox(height: AppSize.h8),
            Text(
              "Get Started",
              style: textStyle(
                fontSize: 30,
                isColor: true,
                color: Colors.black,
              ),
            ),
            Text(
              "Go and enjoy our features for free and\n make your life easy with us.",
              textAlign: TextAlign.center,
              style: textStyle(
                fontSize: 18,
                isColor: true,
                color: Colors.black,
              ),
            ),
            SizedBox(height: AppSize.h4),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset("assets/images/LowerCurveImage.png"),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () async {
                      final deviceId = await PrefUtils.getOrCreateUserId();
                      OneSignal.login(deviceId);
                      print("Login successfully and user id is:$deviceId");
                      Navigator.pushNamed(
                        context,
                        RoutesName.bottomNavigationScreen,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.amber.shade600,
                      radius: 35,
                      foregroundColor: Colors.amber,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
