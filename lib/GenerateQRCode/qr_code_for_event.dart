import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/Result/QRCodeData/q_r_code.dart';

import '../ReusableWidget/generate_button.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';

class QrCodeForEvent extends StatefulWidget {
  const QrCodeForEvent({super.key});

  @override
  State<QrCodeForEvent> createState() => _QrCodeForEventState();
}

class _QrCodeForEventState extends State<QrCodeForEvent> {
  final eventNameController = TextEditingController();
  final startDateTimeController = TextEditingController();
  final endDateTimeController = TextEditingController();
  final eventLocationController = TextEditingController();
  final descriptionController = TextEditingController();

  void generateQrCode() {
    final eventName = eventNameController.text.trim();
    final startDateTime = startDateTimeController.text.trim();
    final endDateTime = endDateTimeController.text.trim();
    final eventLocation = eventLocationController.text.trim();
    final description = descriptionController.text.trim();
    final eventOutput="Event Data\n"
        "Event Name:$eventName\n"
        "StartDateTime:$startDateTime\n"
        "EndDateTime:$endDateTime\n"
        "LOCATION:$eventLocation\n"
        "DESCRIPTION:$description";

    if (eventName.isEmpty ||
        startDateTime.isEmpty ||
        endDateTime.isEmpty ||
        eventLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields for generating qr code"),
        ),
      );
      return;
    }
    final qrData=eventOutput;
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
                  "Event",
                  style: GoogleFonts.akayaTelivigala(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Center(child: Image.asset("assets/images/EventIcon.png")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Event Name",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: eventNameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter event name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Start Date and Time",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: startDateTimeController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "12 Dec 2022, 10:40 pm",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "End Date and Time",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: endDateTimeController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "12 Dec 2022, 10:40 pm",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Event Location",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: eventLocationController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter location",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: GoogleFonts.akayaTelivigala(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: descriptionController,
                        style: TextStyle(color: Colors.white),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter any details",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      GenerateButton(title: "Generate QR Code", onTap:generateQrCode),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .09),
          ],
        ),
      ),
    );
  }
}
