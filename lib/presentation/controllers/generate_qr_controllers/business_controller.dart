import '../../../core/util/validators.dart';

class BusinessController {
  final String industryName,
      countryName,
      cityName,
      companyName,
      jobName,
      address,
      phone,
      email,
      url;

  BusinessController({
    required this.companyName,
    required this.jobName,
    required this.industryName,
    required this.email,
    required this.cityName,
    required this.countryName,
    required this.address,
    required this.phone,
    required this.url,
  });

  String? validity() {
    final companyNameTextError = Validation.textValidation("Company Name")(
      companyName,
    );
    if (companyNameTextError != null) {
      return companyNameTextError;
    }
    final industryNameTextError = Validation.textValidation(
      "IndustryName Name",
    )(industryName);
    if (industryNameTextError != null) {
      return industryNameTextError;
    }

    final phoneNumberError = Validation.phoneNumberValidity("Phone Number")(
      phone,
    );
    if (phoneNumberError != null) {
      return phoneNumberError;
    }
    final emailAddressError = Validation.emailValidity("Email")(email);
    if (emailAddressError != null) {
      return emailAddressError;
    }
    final websiteUrlValidity = Validation.websiteUrlValidity("Website Url")(
      url,
    );
    if (websiteUrlValidity != null) {
      return websiteUrlValidity;
    }
    final addressNameTextError = Validation.textValidation("Address")(address);
    if (addressNameTextError != null) {
      return addressNameTextError;
    }
    final countryNameTextError = Validation.textValidation("Country Name")(
      countryName,
    );
    if (countryNameTextError != null) {
      return countryNameTextError;
    }
    final cityNameTextError = Validation.textValidation("City Name")(cityName);
    if (cityNameTextError != null) {
      return cityNameTextError;
    }
    return null;
  }
}
