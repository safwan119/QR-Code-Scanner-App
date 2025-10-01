import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  List imageList = [
    "assets/images/TextPic.png",
    "assets/images/WebsitePic.png",
    "assets/images/WifiPic.png",
    "assets/images/EventPic.png",
    "assets/images/ContactPic.png",
    "assets/images/BusinessPic.png",
    "assets/images/LocationPic.png",
    "assets/images/WhatsappPic.png",
    "assets/images/EmailPic.png",
    "assets/images/TwitterPic.png",
    "assets/images/InstagramPic.png",
    "assets/images/TelephonePic.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black38,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 0),
                  Text(
                    "Generate QR",
                    style: GoogleFonts.akayaTelivigala(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset("assets/images/DrawerPic.png"),
                  ),
                ],
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
                    return Image.asset(imageList[index]);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.22,),
            ],
          ),
        ),
      ),
    );
  }
}
