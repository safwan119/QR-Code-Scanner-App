import 'package:flutter/material.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';
import 'package:qr_code_scanner/SavingCreateQrCode/save_qr_code_services.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

import '../ReusableWidget/generate_button.dart';
import '../constants/controllers.dart';

class QrCodeForWifi extends StatefulWidget {
  const QrCodeForWifi({super.key});

  @override
  State<QrCodeForWifi> createState() => _QrCodeForWifiState();
}

class _QrCodeForWifiState extends State<QrCodeForWifi> {
  @override
  void dispose() {
    Controllers.networkNameController.dispose();
    Controllers.passwordController.dispose();
    super.dispose();
  }
  void generateQrCode(){
    final input="WIFI:S:${Controllers.networkName};T:WPA;P:${Controllers.password};H:false;";
    if(Controllers.networkName.isEmpty || Controllers.password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,
              content: Text("Please complete the required fields")));
      return;
    }
    final qrData=input;
    SaveQrCode saveQrCode=SaveQrCode();
    saveQrCode.saveQrCodeData(qrData);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCode(qrData)));
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
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/ArrowBackPic.png"),
                ),
                Text(
                  "Wi-Fi",
                  style:textStyle(fontSize: 22)
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .13),
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
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                      Center(child: Image.asset("assets/images/WifiIcon.png")),
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Network",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.networkNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter network name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .02),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: Controllers.passwordController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                      GenerateButton(title: "Generate QR Code", onTap: generateQrCode,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .03),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
