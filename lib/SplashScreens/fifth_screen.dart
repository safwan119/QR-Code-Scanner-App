import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';


class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber.shade600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: ClipRRect(
                    child: Image.asset("assets/images/QRCodeImage.png"),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .16),
              Card(margin: EdgeInsets.zero,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(62),
                    topRight: Radius.circular(62),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 40,
                        width: 165,
                        child: Divider(thickness: 7, color: Colors.amber,radius: BorderRadius.circular(10),),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Text(
                      "Get Started",
                      style:textStyle(fontSize: 30)
                    ),
                    Text(
                      "Go and enjoy our features for free and\n make your life easy with us.",
                      textAlign: TextAlign.center,
                      style:textStyle(fontSize: 18)
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    InkWell(onTap: (){
                        Get.toNamed(RoutesName.sixthScreen);
                      },
                          child: Image.asset("assets/images/letsGo.png")),
                    SizedBox(height: MediaQuery.of(context).size.height * .10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
