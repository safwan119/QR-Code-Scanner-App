import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/GenerateQRCode/qr_code_for_contact.dart';
import 'package:qr_code_scanner/constants/controllers.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/business_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_button.dart';
import '../core/util/validators.dart';

class QrCodeForBusiness extends StatefulWidget {
  const QrCodeForBusiness({super.key});

  @override
  State<QrCodeForBusiness> createState() => _QrCodeForBusinessState();
}

class _QrCodeForBusinessState extends State<QrCodeForBusiness> {
  @override
  void dispose() {
    Controllers.countryController.dispose();
    Controllers.industryController.dispose();
    Controllers.phoneController.dispose();
    Controllers.emailController.dispose();
    Controllers.addressController.dispose();
    Controllers.cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final businessController = Get.find<BusinessController>();
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(ImagePath.arrowBackImage),
                ),
                Text("Business", style: textStyle(fontSize: 22)),
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
                        child: Image.asset("assets/images/BusinessIcon.png"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Company Name",
                          style: textStyle(fontSize: 22),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormFieldReusableWidget(
                        hintText: "Enter name",
                        validator: Validation.textValidation("Company Name"),
                        controller: Controllers.companyController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Industry", style: textStyle(fontSize: 22)),
                      ),
                      SizedBox(height: 10),
                      TextFormFieldReusableWidget(
                        hintText: "e.g Food/Agency",
                        validator: Validation.textValidation("Industry Name"),
                        controller: Controllers.industryController,
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Phone",
                                    style: textStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormFieldReusableWidget(
                                  hintText: "Enter phone",
                                  validator: Validation.phoneNumberValidity(
                                    "Phone Number",
                                  ),
                                  controller: Controllers.phoneController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: textStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormFieldReusableWidget(
                                  hintText: "Enter email",
                                  validator: Validation.emailValidity("Email"),
                                  controller: Controllers.emailController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Website", style: textStyle(fontSize: 22)),
                      ),
                      TextFormFieldReusableWidget(
                        hintText: "Enter website",
                        validator: Validation.websiteUrlValidity("Website Url"),
                        controller: Controllers.websiteController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Address", style: textStyle(fontSize: 22)),
                      ),
                      TextFormFieldReusableWidget(
                        hintText: "Enter address",
                        controller: Controllers.addressController,
                        validator: Validation.textValidation("Address"),
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "City",
                                    style: textStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormFieldReusableWidget(
                                  hintText: "Enter city",
                                  validator: Validation.textValidation(
                                    "City Name",
                                  ),
                                  controller: Controllers.cityController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Country",
                                    style: textStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormFieldReusableWidget(
                                  hintText: "Enter Country",
                                  validator: Validation.textValidation(
                                    "Country Name",
                                  ),
                                  controller: Controllers.countryController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      GenerateButton(
                        title: "Generate QR Code",
                        onTap: businessController.generateBusinessQr,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .13),
          ],
        ),
      ),
    );
  }
}
