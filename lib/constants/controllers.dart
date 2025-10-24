import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Controllers {
  //Controller for generating qr code
  static final companyController = TextEditingController();
  static final industryController = TextEditingController();
  static final phoneController = TextEditingController();
  static final emailController = TextEditingController();
  static final websiteController = TextEditingController();
  static final addressController = TextEditingController();
  static final cityController = TextEditingController();
  static final countryController = TextEditingController();
  static final firstNameController = TextEditingController();
  static final lastNameController = TextEditingController();
  static final jobController = TextEditingController();
  static final eventNameController = TextEditingController();
  static final startDateTimeController = TextEditingController();
  static final endDateTimeController = TextEditingController();
  static final eventLocationController = TextEditingController();
  static final descriptionController = TextEditingController();
  static final locationNameController = TextEditingController();
  static final textController = TextEditingController();
  static final userNameController = TextEditingController();
  static final urlController = TextEditingController();
  static TextEditingController whatsappNumberController = TextEditingController();
  static final networkNameController = TextEditingController();
  static final passwordController = TextEditingController();
  static final twitterController = TextEditingController();
  static final scannerController = MobileScannerController();

  //.trim() is used

  static final companyName = companyController.text.trim();
  static final industryName = industryController.text.trim();
  static final phoneNumber = phoneController.text.trim();
  static final emailAddress = emailController.text.trim();
  static final websiteUrl = websiteController.text.trim();
  static final address = addressController.text.trim();
  static final cityName = cityController.text.trim();
  static final countryName = countryController.text.trim();
  static final firstName=firstNameController.text.trim();
  static final lastName=lastNameController.text.trim();
  static final jobName=jobController.text.trim();
  static final eventName=eventNameController.text.trim();
  static final startDateTime=startDateTimeController.text.trim();
  static final endDateTime=endDateTimeController.text.trim();
  static final eventLocation=eventLocationController.text.trim();
  static final description=descriptionController.text.trim();
  static final locationName=locationNameController.text.trim();
  static final textName=textController.text.trim();
  static final userName=userNameController.text.trim();
  static final url=urlController.text.trim();
  static final whatsappNumber=whatsappNumberController.text.trim();
  static final networkName=networkNameController.text.trim();
  static final password=passwordController.text.trim();
  static final twitterUserName=twitterController.text.trim();
}
