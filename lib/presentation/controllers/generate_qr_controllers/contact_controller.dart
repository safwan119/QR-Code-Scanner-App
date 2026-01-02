import '../../../core/util/validators.dart';

class ContactController {
  final String firstName,
      lastName,
      countryName,
      cityName,
      companyName,
      jobName,
      address,
      phone,
      email,
      url;

  ContactController({
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.jobName,
    required this.email,
    required this.cityName,
    required this.countryName,
    required this.address,
    required this.phone,
    required this.url,
  });

  String? validity() {
    final firstNameTextError = Validation.textValidation("First Name")(
      firstName,
    );
    if (firstNameTextError != null) {
      return firstNameTextError;
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
    final companyNameTextError = Validation.textValidation("Company Name")(
      companyName,
    );
    if (companyNameTextError != null) {
      return companyNameTextError;
    }
    final jobNameTextError = Validation.textValidation("Job Name")(jobName);
    if (jobNameTextError != null) {
      return jobNameTextError;
    }
    final addressNameTextError = Validation.textValidation("Address")(address);
    if (addressNameTextError != null) {
      return addressNameTextError;
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
    return null;
  }
}
