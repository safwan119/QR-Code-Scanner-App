import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/form_fields/text_form_field_reusable_widget.dart';
import '../ReusableWidget/generate_button.dart';
import '../bloc/form/form_bloc.dart';
import '../bloc/form/form_state.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../core/util/validators.dart';
import '../route/routes_name.dart';

class QrCodeForBusiness extends StatefulWidget {
  const QrCodeForBusiness({super.key});

  @override
  State<QrCodeForBusiness> createState() => _QrCodeForBusinessState();
}

class _QrCodeForBusinessState extends State<QrCodeForBusiness> {
  late FormBloc _formBloc;
  final _formKey = GlobalKey<FormState>();
  final FocusNode companyNameFocus = FocusNode();
  final FocusNode industryNameFocus = FocusNode();
  final FocusNode phoneNumberFocus = FocusNode();
  final FocusNode EmailFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode cityNameFocus = FocusNode();
  final FocusNode countryNameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _formBloc = FormBloc();
  }

  @override
  void dispose() {
    _formBloc.close();
    companyNameFocus.dispose();
    industryNameFocus.dispose();
    phoneNumberFocus.dispose();
    EmailFocus.dispose();
    websiteFocus.dispose();
    addressFocus.dispose();
    cityNameFocus.dispose();
    countryNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => _formBloc,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(AppImages.arrowBackImage),
                    ),
                    Text("Business", style: textStyle(fontSize: 22)),
                  ],
                ),
                SizedBox(height: AppSize.h3),
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
                          SizedBox(height: AppSize.h3),
                          Center(
                            child: Image.asset(
                              "assets/images/BusinessIcon.png",
                            ),
                          ),
                          SizedBox(height: AppSize.h4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Company Name",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: AppSize.h2),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.companyName != current.companyName,
                            builder: (context, state) {
                              return TextFormFieldReusableWidget(
                                hintText: "Enter Company",
                                focusNode: companyNameFocus,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeCompanyName(companyName: value ?? ''),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(industryNameFocus);
                                },
                                validator: Validation.textValidation(
                                  "Company Name",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppSize.h4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Industry",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: AppSize.h2),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.industryName != current.industryName,
                            builder: (context, state) {
                              return TextFormFieldReusableWidget(
                                hintText: "e.g Food/Agency",
                                focusNode: industryNameFocus,
                                validator: Validation.textValidation(
                                  "Industry Name",
                                ),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeIndustryName(
                                      industryName: value ?? '',
                                    ),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(phoneNumberFocus);
                                },
                              );
                            },
                          ),
                          SizedBox(height: AppSize.h4),
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
                                    SizedBox(height: AppSize.h2),
                                    BlocBuilder<FormBloc, FormsState>(
                                      buildWhen: (previous, current) =>
                                          previous.phoneNumber !=
                                          current.phoneNumber,
                                      builder: (context, state) {
                                        return TextFormFieldReusableWidget(
                                          focusNode: phoneNumberFocus,
                                          hintText: "Enter phone",
                                          onChanged: (value) {
                                            context.read<FormBloc>().add(
                                              ChangePhoneNumber(
                                                phoneNumber: value ?? "",
                                              ),
                                            );
                                          },
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(
                                              context,
                                            ).requestFocus(EmailFocus);
                                          },
                                          validator:
                                              Validation.phoneNumberValidity(
                                                "Phone Number",
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppSize.w2),
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
                                    SizedBox(height: AppSize.h2),
                                    BlocBuilder<FormBloc, FormsState>(
                                      buildWhen: (previous, current) =>
                                          previous.email != current.email,
                                      builder: (context, state) {
                                        return TextFormFieldReusableWidget(
                                          hintText: "Enter email",
                                          focusNode: EmailFocus,
                                          onChanged: (value) {
                                            context.read<FormBloc>().add(
                                              ChangeEmailField(
                                                email: value ?? '',
                                              ),
                                            );
                                          },
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(
                                              context,
                                            ).requestFocus(websiteFocus);
                                          },
                                          validator: Validation.emailValidity(
                                            "Email",
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSize.h4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Website",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.url != current.url,
                            builder: (context, state) {
                              return TextFormFieldReusableWidget(
                                hintText: "Enter website",
                                focusNode: websiteFocus,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeWebsiteUrl(url: value ?? ""),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(addressFocus);
                                },
                                validator: Validation.websiteUrlValidity(
                                  "Website Url",
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppSize.h4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Address",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.addressName != current.addressName,
                            builder: (context, state) {
                              return TextFormFieldReusableWidget(
                                hintText: "Enter address",
                                focusNode: addressFocus,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeAddress(addressName: value ?? ""),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(cityNameFocus);
                                },
                                validator: Validation.textValidation("Address"),
                              );
                            },
                          ),
                          SizedBox(height: AppSize.h4),
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
                                    SizedBox(height: AppSize.h2),
                                    BlocBuilder<FormBloc, FormsState>(
                                      buildWhen: (previous, current) =>
                                          previous.cityName != current.cityName,
                                      builder: (context, state) {
                                        return TextFormFieldReusableWidget(
                                          hintText: "Enter city",
                                          focusNode: cityNameFocus,
                                          validator: Validation.textValidation(
                                            "City Name",
                                          ),
                                          onChanged: (value) {
                                            context.read<FormBloc>().add(
                                              ChangeCityName(
                                                cityName: value ?? "",
                                              ),
                                            );
                                          },
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(
                                              context,
                                            ).requestFocus(countryNameFocus);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: AppSize.w2),
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
                                    SizedBox(height: AppSize.h2),
                                    BlocBuilder<FormBloc, FormsState>(
                                      buildWhen: (previous, current) =>
                                          previous.countryName !=
                                          current.countryName,
                                      builder: (context, state) {
                                        return TextFormFieldReusableWidget(
                                          hintText: "Enter Country",
                                          focusNode: countryNameFocus,
                                          onChanged: (value) {
                                            context.read<FormBloc>().add(
                                              ChangeCountryName(
                                                countryName: value ?? "",
                                              ),
                                            );
                                          },
                                          validator: Validation.textValidation(
                                            "Country Name",
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSize.h4),
                          BlocListener<FormBloc, FormsState>(
                            listenWhen: (previous, current) =>
                                previous.status != current.status,
                            listener: (context, state) {
                              if (state.status == Status.initial) {
                                ShortMessage.showSuccessMessage(
                                  context,
                                  "Loading..",
                                );
                              }
                              if (state.status == Status.error) {
                                ShortMessage.showErrorMessage(
                                  context,
                                  state.message,
                                );
                              }
                              if (state.status == Status.complete) {
                                ShortMessage.showSuccessMessage(
                                  context,
                                  state.message,
                                );
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.qrCodeScreen,
                                  arguments: state.qrResult,
                                );
                              }
                            },
                            child: BlocBuilder<FormBloc, FormsState>(
                              builder: (context, state) {
                                return GenerateButton(
                                  title: "Generate QR Code",
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<FormBloc>().add(
                                        BusinessQrGenerationButton(),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: AppSize.h3),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.h3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
