import 'package:bloc/bloc.dart';
import 'package:qr_code_scanner/core/enum/status.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/business_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/contact_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/email_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/event_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/instagram_twitter_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/location_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/phone_number_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/website_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/generate_qr_controllers/wifi_controller.dart';
import '../../SavingCreateQrCode/save_qr_code_services.dart';
import '../../presentation/controllers/generate_qr_controllers/text_controller.dart';
import 'form_state.dart';
import 'form_event.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  FormBloc() : super(FormsState()) {
    on<ChangeText>(_changeText);
    on<ChangeWebsiteUrl>(_changeWebsiteUrl);
    on<ChangeNetworkName>(_changeNetworkName);
    on<ChangeNetworkPassword>(_changeNetworkPassword);
    on<ChangeWhatsappField>(_changeWhatsappField);
    on<ChangeTwitterUserNameField>(_changeTwitterUserName);
    on<ChangeEmailField>(_changeEmail);
    on<ChangeInstagramUser>(_changeInstagramUser);
    on<ChangePhoneNumber>(_changePhoneNumber);
    on<ChangeFirstName>(_changeFirstName);
    on<ChangeSecondName>(_changeLastName);
    on<ChangeCompanyName>(_companyName);
    on<ChangeJobName>(_changeJobName);
    on<ChangeCountryName>(_changeCountryName);
    on<ChangeCityName>(_changeCityName);
    on<ChangeAddress>(_addressName);
    on<ChangeIndustryName>(_changeIndustryName);
    on<ChangeEventName>(_changeEventName);
    on<ChangeStartDateTime>(_changeStartDateTime);
    on<ChangeEndDateTime>(_changeEndDateTime);
    on<ChangeEventLocation>(_changeEventLocation);
    on<ChangeDescription>(_changeDescription);
    on<ChangeLocationName>(_locationName);
    on<TextQrGenerationButton>(_textGenerationButton);
    on<UrlQrGenerationButton>(_urlGenerationButton);
    on<WifiQrGenerationButton>(_wifiQrGenerationButton);
    on<LocationQrGenerationButton>(_locationQrGenerationButton);
    on<InstagramQrGenerationButton>(_instagramQrGenerationButton);
    on<TwitterQrGenerationButton>(_twitterQrGenerationButton);
    on<WhatsappQrGenerationButton>(_whatsappQrGenerationButton);
    on<PhoneQrGenerationButton>(_phoneQrGenerationButton);
    on<EmailQrGenerationButton>(_emailQrGenerationButton);
    on<EventQrGenerationButton>(_eventQrGenerationButton);
    on<ContactQrGenerationButton>(_contactQrGenerationButton);
    on<BusinessQrGenerationButton>(_businessQrGenerationButton);
  }

  void _changeText(ChangeText event, Emitter<FormsState> emit) {
    emit(state.copyWith(text: event.text));
  }

  void _changeWebsiteUrl(ChangeWebsiteUrl event, Emitter<FormsState> emit) {
    emit(state.copyWith(url: event.url));
  }

  void _changeNetworkName(ChangeNetworkName event, Emitter<FormsState> emit) {
    emit(state.copyWith(networkName: event.networkName));
  }

  void _changeNetworkPassword(
    ChangeNetworkPassword event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(networkPassword: event.networkPassword));
  }

  void _changeWhatsappField(
    ChangeWhatsappField event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(whatsappNumber: event.whatsappNumber));
  }

  void _changeTwitterUserName(
    ChangeTwitterUserNameField event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(twitterUsername: event.userName));
  }

  void _changeEmail(ChangeEmailField event, Emitter<FormsState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _changeInstagramUser(
    ChangeInstagramUser event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(instagramUsername: event.instagramUserName));
  }

  void _changePhoneNumber(ChangePhoneNumber event, Emitter<FormsState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _changeFirstName(ChangeFirstName event, Emitter<FormsState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _changeLastName(ChangeSecondName event, Emitter<FormsState> emit) {
    emit(state.copyWith(lastName: event.secondName));
  }

  void _companyName(ChangeCompanyName event, Emitter<FormsState> emit) {
    emit(state.copyWith(companyName: event.companyName));
  }

  void _changeJobName(ChangeJobName event, Emitter<FormsState> emit) {
    emit(state.copyWith(jobName: event.jobName));
  }

  void _addressName(ChangeAddress event, Emitter<FormsState> emit) {
    emit(state.copyWith(addressName: event.addressName));
  }

  void _changeCityName(ChangeCityName event, Emitter<FormsState> emit) {
    emit(state.copyWith(cityName: event.cityName));
  }

  void _changeCountryName(ChangeCountryName event, Emitter<FormsState> emit) {
    emit(state.copyWith(countryName: event.countryName));
  }

  void _locationName(ChangeLocationName event, Emitter<FormsState> emit) {
    emit(state.copyWith(locationName: event.locationName));
  }

  void _changeIndustryName(ChangeIndustryName event, Emitter<FormsState> emit) {
    emit(state.copyWith(industryName: event.industryName));
  }

  void _changeEventName(ChangeEventName event, Emitter<FormsState> emit) {
    emit(state.copyWith(eventName: event.eventName));
  }

  void _changeStartDateTime(
    ChangeStartDateTime event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(startDateTime: event.startTime));
  }

  void _changeEndDateTime(ChangeEndDateTime event, Emitter<FormsState> emit) {
    emit(state.copyWith(endDateTime: event.endTime));
  }

  void _changeEventLocation(
    ChangeEventLocation event,
    Emitter<FormsState> emit,
  ) {
    emit(state.copyWith(eventLocation: event.eventLocation));
  }

  void _changeDescription(ChangeDescription event, Emitter<FormsState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _textGenerationButton(
    TextQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final TextController textController = TextController(value: state.text);
    final textValidationError = textController.validity();
    if (textValidationError != null) {
      emit(state.copyWith(message: textValidationError, status: Status.error));
      return;
    }
    final qrData = state.text;
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(qrData)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _urlGenerationButton(
    UrlQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final WebSiteController urlController = WebSiteController(value: state.url);
    final urlValidationError = urlController.validity();
    if (urlValidationError != null) {
      emit(state.copyWith(message: urlValidationError, status: Status.error));
      return;
    }
    final websiteUrlLink = state.url;
    final qrData = websiteUrlLink;
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(qrData)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _wifiQrGenerationButton(
    WifiQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final WifiController wifiController = WifiController(
      networkName: state.networkName,
      networkPassword: state.networkPassword,
    );
    final wifiValidationError = wifiController.validity();

    final input =
        "WIFI:S:${state.networkName};T:WPA;P:${state.networkPassword};H:false;";

    if (wifiValidationError != null) {
      emit(state.copyWith(message: wifiValidationError, status: Status.error));
      return;
    }
    emit(state.copyWith(qrResult: input));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(input)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _locationQrGenerationButton(
    LocationQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final LocationController locationController = LocationController(
      value: state.locationName,
    );
    final locationValidation = locationController.validity();

    if (locationValidation != null) {
      emit(state.copyWith(message: locationValidation, status: Status.error));
      return;
    }
    final encodedLocation = Uri.encodeComponent(state.locationName);
    final input =
        "https://www.google.com/maps/search/?api=1&query=$encodedLocation";
    emit(state.copyWith(qrResult: input));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(input)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _instagramQrGenerationButton(
    InstagramQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final InstagramTwitterController instagramController =
        InstagramTwitterController(value: state.instagramUsername);
    final locationValidation = instagramController.instagramValidity();

    if (locationValidation != null) {
      emit(state.copyWith(message: locationValidation, status: Status.error));
      return;
    }
    final instagramUrl = "https://www.instagram.com/${state.instagramUsername}";
    emit(state.copyWith(qrResult: instagramUrl));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(instagramUrl)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _twitterQrGenerationButton(
    TwitterQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final InstagramTwitterController instagramController =
        InstagramTwitterController(value: state.twitterUsername);
    final locationValidation = instagramController.twitterValidity();

    if (locationValidation != null) {
      emit(state.copyWith(message: locationValidation, status: Status.error));
      return;
    }
    final input = "https://twitter.com/${state.twitterUsername}";
    emit(state.copyWith(qrResult: input));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(input)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _whatsappQrGenerationButton(
    WhatsappQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final PhoneNumberController whatsappController = PhoneNumberController(
      value: state.whatsappNumber,
    );
    final whatsappValidationError = whatsappController.whatsappNumberValidity();

    if (whatsappValidationError != null) {
      emit(
        state.copyWith(message: whatsappValidationError, status: Status.error),
      );
      return;
    }
    final input = "http://wa.me/${state.whatsappNumber}";
    emit(state.copyWith(qrResult: input));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(input)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _phoneQrGenerationButton(
    PhoneQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final PhoneNumberController whatsappController = PhoneNumberController(
      value: state.phoneNumber,
    );
    final whatsappValidationError = whatsappController.phoneNumberValidity();

    if (whatsappValidationError != null) {
      emit(
        state.copyWith(message: whatsappValidationError, status: Status.error),
      );
      return;
    }
    final cleanNumber = state.phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final input = "tel:$cleanNumber";
    emit(state.copyWith(qrResult: input));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(input)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _emailQrGenerationButton(
    EmailQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final EmailController emailController = EmailController(value: state.email);
    final emailValidationError = emailController.validity();

    if (emailValidationError != null) {
      emit(state.copyWith(message: emailValidationError, status: Status.error));
      return;
    }
    final emailInput = "mailto:${state.email}";
    emit(state.copyWith(qrResult: emailInput));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(emailInput)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _eventQrGenerationButton(
    EventQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final EventController eventController = EventController(
      eventLocation: state.eventLocation,
      eventName: state.eventName,
      endTime: state.endDateTime,
      startTime: state.startDateTime,
    );
    final eventValidationError = eventController.validity();

    if (eventValidationError != null) {
      emit(state.copyWith(message: eventValidationError, status: Status.error));
      return;
    }
    final eventDetailOutput =
        "Event Data\n"
        "Event Name:${state.eventName}\n"
        "StartDateTime:${state.startDateTime}\n"
        "EndDateTime:${state.endDateTime}\n"
        "LOCATION:${state.eventLocation}\n"
        "DESCRIPTION:${state.description}";
    emit(state.copyWith(qrResult: eventDetailOutput));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(eventDetailOutput)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _contactQrGenerationButton(
    ContactQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final ContactController contactController = ContactController(
      firstName: state.firstName,
      lastName: state.lastName,
      companyName: state.companyName,
      jobName: state.jobName,
      email: state.email,
      cityName: state.cityName,
      countryName: state.countryName,
      address: state.addressName,
      phone: state.phoneNumber,
      url: state.url,
    );
    final contactValidation = contactController.validity();

    if (contactValidation != null) {
      emit(state.copyWith(message: contactValidation, status: Status.error));
      return;
    }
    final contactDetailOutputs =
        "Contact Detail\n"
        "First Name:${state.firstName}\n"
        "Last Name:${state.lastName}\n"
        "Company Name:${state.companyName}\n"
        "Job Name:${state.jobName}\n"
        "Phone Number:${state.phoneNumber}\n"
        "Email Address:${state.email}\n"
        "Website Url:${state.url}\n"
        "Address:${state.addressName}\n"
        "City Name:${state.cityName}\n"
        "Country Name:${state.countryName}\n";
    emit(state.copyWith(qrResult: contactDetailOutputs));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(contactDetailOutputs)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }

  void _businessQrGenerationButton(
    BusinessQrGenerationButton event,
    Emitter<FormsState> emit,
  ) {
    final BusinessController businessController = BusinessController(
      industryName: state.industryName,
      companyName: state.companyName,
      jobName: state.jobName,
      email: state.email,
      cityName: state.cityName,
      countryName: state.countryName,
      address: state.addressName,
      phone: state.phoneNumber,
      url: state.url,
    );
    final eventValidationError = businessController.validity();

    if (eventValidationError != null) {
      emit(state.copyWith(message: eventValidationError, status: Status.error));
      return;
    }
    final businessDetailOutput =
        "Business Detail\n"
        "Company Name:${state.companyName}\n"
        "Industry:${state.industryName}\n"
        "Phone Number:${state.phoneNumber}\n"
        "Email Address:${state.email}\n"
        "Website Url:${state.url}\n"
        "Address:${state.addressName}\n"
        "City Name:${state.cityName}\n"
        "Country Name:${state.countryName}\n";

    emit(state.copyWith(qrResult: businessDetailOutput));
    SaveQrCode saveQrCode = SaveQrCode();
    saveQrCode
        .saveQrCodeData(businessDetailOutput)
        .then((value) {
          emit(
            state.copyWith(
              message: "Qr Generated Successfully",
              status: Status.complete,
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(state.copyWith(message: error.toString(), status: Status.error));
        });
  }
}
