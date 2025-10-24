import 'package:qr_code_scanner/constants/controllers.dart';

class QrCodeOutputs {
  //businessDetailOutPut of qrCode

  static final businessDetailOutput =
      "Business Detail\n"
      "Company Name:${Controllers.companyName}\n"
      "Industry:${Controllers.industryName}\n"
      "Phone Number:${Controllers.phoneNumber}\n"
      "Email Address:${Controllers.emailAddress}\n"
      "Website Url:${Controllers.websiteUrl}\n"
      "Address:${Controllers.address}\n"
      "City Name:${Controllers.cityName}\n"
      "Country Name:${Controllers.countryName}\n";

  //contactDetailOutPut of qrCode

  static final contactDetailOutputs =
      "Contact Detail\n"
      "First Name:${Controllers.firstName}\n"
      "Last Name:${Controllers.lastName}\n"
      "Company Name:${Controllers.companyName}\n"
      "Job Name:${Controllers.jobName}\n"
      "Phone Number:${Controllers.phoneNumber}\n"
      "Email Address:${Controllers.emailAddress}\n"
      "Website Url:${Controllers.websiteUrl}\n"
      "Address:${Controllers.address}\n"
      "City Name:${Controllers.cityName}\n"
      "Country Name:${Controllers.countryName}\n";

  //eventDetailOutput of qrCode
 static final eventDetailOutput =
      "Event Data\n"
      "Event Name:${Controllers.eventName}\n"
      "StartDateTime:${Controllers.startDateTime}\n"
      "EndDateTime:${Controllers.endDateTime}\n"
      "LOCATION:${Controllers.eventLocation}\n"
      "DESCRIPTION:${Controllers.description}";
}
