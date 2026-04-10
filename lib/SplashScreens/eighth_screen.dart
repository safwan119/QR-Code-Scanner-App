import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/route/routes_name.dart';

class EighthScreen extends StatelessWidget {
  const EighthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade600,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: AppSize.getHeight(30.0)),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CustomPaint(
                    painter: CustomCircle(),
                    child: Image.asset("assets/images/stackRedImage.png"),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [const Color(0xFF9E7C49), const Color(0xFF755D30)],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.shade700,
                          spreadRadius: 8,
                          blurRadius: 30,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.h5),
                  Text("Get Started", style: textStyle(fontSize: 30)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 53,
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
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.ninthScreen),
                    child: Image.asset("assets/images/amberLetsStart.png"),
                  ),
                  SizedBox(height: AppSize.h9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.deepOrange.shade700;

    canvas.drawCircle(
      Offset(size.width / 1.9, size.height / 1.9),
      size.width / 1.3,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
