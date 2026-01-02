import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/button_click_paths.dart';
import 'package:qr_code_scanner/constants/image_string.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  List imageList = ImageString.imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black38,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .07),
              Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Generate QR", style: textStyle(fontSize: 30)),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          RoutesName.settingScreen,
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: imageList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    crossAxisSpacing: 11.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ButtonClickPaths.buttonClick(context, index);
                      },
                      child: Image.asset(imageList[index]),
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .22),
            ],
          ),
        ),
      ),
    );
  }
}
