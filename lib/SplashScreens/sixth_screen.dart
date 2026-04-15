import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

import '../constants/app_size.dart';

class SixthScreen extends StatelessWidget {
  const SixthScreen({super.key});

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
              SizedBox(height: AppSize.getHeight(20.0)),
              Center(child: Image.asset("assets/images/QRCodeImage.png")),
              SizedBox(height: AppSize.getHeight(12.0)),
              Align(
                alignment: Alignment.centerLeft,
                child: ClipPath(
                  clipper: TopCurveClipper(),
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.black,
                  ),
                ),
              ),
              Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(96),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    SizedBox(height: AppSize.h3),
                    Text("Get Started", style: textStyle(fontSize: 30)),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          bottom: 20,
                          top: .1,
                        ),
                        child: SizedBox(
                          width: 90,
                          child: Divider(
                            thickness: 7,
                            color: Colors.amber,
                            radius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Go and enjoy our features for free and\n make your life easy with us.",
                      textAlign: TextAlign.center,
                      style: textStyle(fontSize: 18),
                    ),
                    SizedBox(height: AppSize.h3),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.seventhScreen);
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
                    SizedBox(height: AppSize.h6),
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

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.quadraticBezierTo(
      size.width * .14,
      size.height * 2,
      size.width * 5,
      size.height * 2,
    );
    path.lineTo(0, size.height * 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
