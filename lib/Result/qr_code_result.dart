import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeResult extends StatelessWidget {
  final String qrData;
   QrCodeResult(this.qrData, {super.key});
  late final String shareMessage = 'Qr Code data is: $qrData';
  String? shareQrDataAsText(String qrData) {
    SharePlus.instance.share(
      ShareParams(
        text: shareMessage,
        subject: 'My QR Code Link',
      )
    );
    return null;
  }
  void copyQrDataToClipboard(String qrData) {
    Clipboard.setData(ClipboardData(text: qrData));
}
  Future<void> launchQrData(BuildContext context) async {
    Uri? uri;
    try {
     uri = Uri.parse(qrData);
    } on FormatException {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.red,
            content: Text('This is a text.Use Copy button.')),
      );
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred: $e')),
      );
      return;
    }
    if (qrData.startsWith('http://')||qrData.startsWith('https://') || qrData.startsWith('http://googleusercontent.com/maps.google.com/7')) {
      final urlString = qrData.startsWith('http') ? qrData : 'https://$qrData';
      final uri = Uri.parse(urlString.trim());
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    else if (qrData.startsWith('http://wa.me/') || qrData.startsWith("tel") || qrData.startsWith("mailto")) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
      else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.red,
              content: Text('Not a recognized link/number. Please use Copy button.')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Column(
        children: [
          Row(
            children: [
              InkWell(onTap: (){
                Navigator.pop(context);
              },
                  child: Image.asset("assets/images/ArrowBackPic.png")),
              Text(
                "Result",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                ),
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
                        Image.asset("assets/images/QRCodeDataPic.png"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Data",
                              style: GoogleFonts.akayaTelivigala(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              DateFormat("dd MMMM yyyy, hh:mm a").format(DateTime.now()),
                              style: GoogleFonts.akayaTelivigala(
                                color: Colors.white54,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.white10, thickness: 3),
                    SelectableText(onTap: () {
                      launchQrData(context);
                    },
                      selectionColor: Colors.blue,
                      minLines: 1,
                      qrData,
                      style: GoogleFonts.akayaTelivigala(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCode(qrData)));
                      },
                      child: Text(
                        "Show QR Code",
                        style: GoogleFonts.akayaTelivigala(
                          color: Colors.amber.shade600,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
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
                    shareQrDataAsText(qrData);
                  },
                      child: Image.asset("assets/images/SharePic.png")),
                  const SizedBox(height: 4),
                  Text(
                    "Share",
                    style: GoogleFonts.akayaTelivigala(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(onTap: (){
                    copyQrDataToClipboard(qrData);
                  },
                      child: Image.asset("assets/images/CopyPic.png")),
                  SizedBox(height: 4),
                  Text(
                    "Copy",
                    style: GoogleFonts.akayaTelivigala(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
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
