import 'package:flutter/material.dart';
import 'package:qr_code_scanner/constants/qr_code_outputs.dart';
import 'package:qr_code_scanner/constants/text_style.dart';

import '../Result/QRCodeData/q_r_code.dart';
import '../ReusableWidget/generate_button.dart';
import '../SavingCreateQrCode/save_qr_code_services.dart';
import '../constants/controllers.dart';

class QrCodeForContact extends StatefulWidget {
  const QrCodeForContact({super.key});

  @override
  State<QrCodeForContact> createState() => _QrCodeForContactState();
}

class _QrCodeForContactState extends State<QrCodeForContact> {
  void generateQrCode() {
    if (Controllers.firstName.isEmpty ||
        Controllers.lastName.isEmpty ||
        Controllers.countryName.isEmpty ||
        Controllers.jobName.isEmpty ||
        Controllers.phoneNumber.isEmpty ||
        Controllers.emailAddress.isEmpty ||
        Controllers.address.isEmpty ||
        Controllers.cityName.isEmpty ||
        Controllers.countryName.isEmpty
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red,
          content: Text("Please fill all fields for generating qr code"),
        ),
      );
      return;
    }
    final qrData=QrCodeOutputs.contactDetailOutputs;
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
                  "Contact",
                  style:textStyle(fontSize: 22)
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
                      Center(
                        child: Image.asset("assets/images/ContactIcon.png"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Align(alignment:Alignment.centerLeft,
                                child: Text(
                                  "First Name",
                                  style:textStyle(fontSize: 20)
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormFieldReusableWidget(hintText: "Enter name", controller: Controllers.firstNameController),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            children: [
                              Align(alignment:Alignment.centerLeft,
                                child: Text(
                                  "Last Name",
                                  style:textStyle(fontSize: 20)
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormFieldReusableWidget(hintText: "Enter name", controller: Controllers.lastNameController),
                            ],
                          ),
                        ),
                      ],
                    ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "Company",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter Company", controller: Controllers.companyController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "Job",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter job", controller: Controllers.jobController),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "Phone",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter phone", controller: Controllers.phoneController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter email", controller: Controllers.emailController),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Website",
                          style:textStyle(fontSize: 22)
                        ),
                      ),
                      TextFormFieldReusableWidget(hintText: "Enter website", controller: Controllers.websiteController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Address",
                          style:textStyle(fontSize: 20)
                        ),
                      ),
                      TextFormFieldReusableWidget(hintText: "Enter address", controller: Controllers.addressController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "City",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter city", controller: Controllers.cityController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              children: [
                                Align(alignment:Alignment.centerLeft,
                                  child: Text(
                                    "Country",
                                    style:textStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormFieldReusableWidget(hintText: "Enter Country", controller: Controllers.countryController),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * .13,
            ),
          ],
        ),
      ),
    );
  }
}
class TextFormFieldReusableWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const TextFormFieldReusableWidget({super.key, required this.hintText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
    );
  }
}

