import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/core/enum/status.dart';

class FormsState extends Equatable {
  final String qrResult;
  final String text;
  final String message;
  final String url;
  final String networkName;
  final String networkPassword;
  final String whatsappNumber;
  final String twitterUsername;
  final String instagramUsername;
  final String email;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String companyName;
  final String jobName;
  final String addressName;
  final String cityName;
  final String countryName;
  final String industryName;
  final String eventName;
  final String startDateTime;
  final String endDateTime;
  final String eventLocation;
  final String description;
  final String locationName;
  final Status status;

  FormsState({
    this.status = Status.initial,
    this.message = "",
    this.qrResult = "",
    this.text = "",
    this.url = "",
    this.networkName = "",
    this.networkPassword = "",
    this.whatsappNumber = "",
    this.twitterUsername = "",
    this.instagramUsername = "",
    this.email = "",
    this.phoneNumber = "",
    this.firstName = "",
    this.lastName = "",
    this.companyName = "",
    this.jobName = "",
    this.addressName = "",
    this.cityName = "",
    this.countryName = "",
    this.industryName = "",
    this.eventName = "",
    this.startDateTime = "",
    this.endDateTime = "",
    this.eventLocation = "",
    this.description = "",
    this.locationName = "",
  });

  List<Object?> get props => [
    text,
    url,
    networkName,
    networkPassword,
    whatsappNumber,
    twitterUsername,
    instagramUsername,
    email,
    phoneNumber,
    firstName,
    lastName,
    companyName,
    jobName,
    addressName,
    cityName,
    countryName,
    industryName,
    eventName,
    startDateTime,
    endDateTime,
    eventLocation,
    description,
    locationName,
    status,
    message,
    qrResult,
  ];

  FormsState copyWith({
    String? qrResult,
    String? message,
    String? text,
    String? url,
    String? networkName,
    String? networkPassword,
    String? whatsappNumber,
    String? twitterUsername,
    String? instagramUsername,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? companyName,
    String? jobName,
    String? addressName,
    String? cityName,
    String? countryName,
    String? industryName,
    String? eventName,
    String? startDateTime,
    String? endDateTime,
    String? eventLocation,
    String? description,
    String? locationName,
    Status? status,
  }) => FormsState(
    text: text ?? this.text,
    email: email ?? this.email,
    addressName: addressName ?? this.addressName,
    cityName: cityName ?? this.cityName,
    companyName: companyName ?? this.companyName,
    countryName: countryName ?? this.countryName,
    description: description ?? this.description,
    endDateTime: endDateTime ?? this.endDateTime,
    eventLocation: eventLocation ?? this.eventLocation,
    eventName: eventName ?? this.eventName,
    firstName: firstName ?? this.firstName,
    industryName: industryName ?? this.industryName,
    instagramUsername: instagramUsername ?? this.instagramUsername,
    jobName: jobName ?? this.jobName,
    lastName: lastName ?? this.lastName,
    locationName: locationName ?? this.locationName,
    networkName: networkName ?? this.networkName,
    networkPassword: networkPassword ?? this.networkPassword,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    startDateTime: startDateTime ?? this.startDateTime,
    twitterUsername: twitterUsername ?? this.twitterUsername,
    url: url ?? this.url,
    whatsappNumber: whatsappNumber ?? this.whatsappNumber,
    status: status ?? this.status,
    message: message ?? this.message,
    qrResult: qrResult ?? this.qrResult,
  );
}
