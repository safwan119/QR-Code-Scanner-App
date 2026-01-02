import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  FormEvent();

  List<Object?> get props => [];
}

class ChangeText extends FormEvent {
  final String text;

  ChangeText({required this.text});

  List<Object?> get props => [text];
}

class ChangeWebsiteUrl extends FormEvent {
  final String url;

  ChangeWebsiteUrl({required this.url});

  List<Object?> get props => [url];
}

class ChangeNetworkName extends FormEvent {
  final String networkName;

  ChangeNetworkName({required this.networkName});

  List<Object?> get props => [networkName];
}

class ChangeNetworkPassword extends FormEvent {
  final String networkPassword;

  ChangeNetworkPassword({required this.networkPassword});

  List<Object?> get props => [networkPassword];
}

class ChangeWhatsappField extends FormEvent {
  final String whatsappNumber;

  ChangeWhatsappField({required this.whatsappNumber});

  List<Object?> get props => [whatsappNumber];
}

class ChangeTwitterUserNameField extends FormEvent {
  final String userName;

  ChangeTwitterUserNameField({required this.userName});

  List<Object?> get props => [userName];
}

class ChangeEmailField extends FormEvent {
  final String email;

  ChangeEmailField({required this.email});

  List<Object?> get props => [email];
}

class ChangeInstagramUser extends FormEvent {
  final String instagramUserName;

  ChangeInstagramUser({required this.instagramUserName});

  List<Object?> get props => [instagramUserName];
}

class ChangePhoneNumber extends FormEvent {
  final String phoneNumber;

  ChangePhoneNumber({required this.phoneNumber});

  List<Object?> get props => [phoneNumber];
}

class ChangeFirstName extends FormEvent {
  final String firstName;

  ChangeFirstName({required this.firstName});

  List<Object?> get props => [firstName];
}

class ChangeSecondName extends FormEvent {
  final String secondName;

  ChangeSecondName({required this.secondName});

  List<Object?> get props => [secondName];
}

class ChangeCompanyName extends FormEvent {
  final String companyName;

  ChangeCompanyName({required this.companyName});

  List<Object?> get props => [companyName];
}

class ChangeJobName extends FormEvent {
  final String jobName;

  ChangeJobName({required this.jobName});

  List<Object?> get props => [jobName];
}

class ChangeAddress extends FormEvent {
  final String addressName;

  ChangeAddress({required this.addressName});

  List<Object?> get props => [addressName];
}

class ChangeCityName extends FormEvent {
  final String cityName;

  ChangeCityName({required this.cityName});

  List<Object?> get props => [cityName];
}

class ChangeCountryName extends FormEvent {
  final String countryName;

  ChangeCountryName({required this.countryName});

  List<Object?> get props => [countryName];
}

class ChangeIndustryName extends FormEvent {
  final String industryName;

  ChangeIndustryName({required this.industryName});

  List<Object?> get props => [industryName];
}

class ChangeEventName extends FormEvent {
  final String eventName;

  ChangeEventName({required this.eventName});

  List<Object?> get props => [eventName];
}

class ChangeStartDateTime extends FormEvent {
  final String startTime;

  ChangeStartDateTime({required this.startTime});

  List<Object?> get props => [startTime];
}

class ChangeEndDateTime extends FormEvent {
  final String endTime;

  ChangeEndDateTime({required this.endTime});

  List<Object?> get props => [endTime];
}

class ChangeEventLocation extends FormEvent {
  final String eventLocation;

  ChangeEventLocation({required this.eventLocation});

  List<Object?> get props => [eventLocation];
}

class ChangeDescription extends FormEvent {
  final String description;

  ChangeDescription({required this.description});

  List<Object?> get props => [description];
}

class ChangeLocationName extends FormEvent {
  final String locationName;

  ChangeLocationName({required this.locationName});

  List<Object?> get props => [locationName];
}

class TextQrGenerationButton extends FormEvent {}

class UrlQrGenerationButton extends FormEvent {}

class WifiQrGenerationButton extends FormEvent {}

class EventQrGenerationButton extends FormEvent {}

class ContactQrGenerationButton extends FormEvent {}

class BusinessQrGenerationButton extends FormEvent {}

class WhatsappQrGenerationButton extends FormEvent {}

class TwitterQrGenerationButton extends FormEvent {}

class InstagramQrGenerationButton extends FormEvent {}

class EmailQrGenerationButton extends FormEvent {}

class PhoneQrGenerationButton extends FormEvent {}

class LocationQrGenerationButton extends FormEvent {}
