import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/button_click_paths.dart';
import 'package:qr_code_scanner/constants/image_string.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class GenerateQrCode extends StatelessWidget {
  GenerateQrCode({super.key});

  final List imageList = ImageString.imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: AppSize.getHeight(100.0)),
          color: Colors.black38,
          child: Column(
            children: [
              SizedBox(height: AppSize.h7),
              Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  );
                },
              ),
              SizedBox(height: AppSize.h5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.zero,
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
            ],
          ),
        ),
      ),
    );
  }
}
