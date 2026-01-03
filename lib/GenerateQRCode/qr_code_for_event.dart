import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_button.dart';
import '../bloc/form/form_bloc.dart';
import '../bloc/form/form_state.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../route/routes_name.dart';

class QrCodeForEvent extends StatefulWidget {
  const QrCodeForEvent({super.key});

  @override
  State<QrCodeForEvent> createState() => _QrCodeForEventState();
}

class _QrCodeForEventState extends State<QrCodeForEvent> {
  late FormBloc _formBloc;
  final FocusNode eventNameFocus = FocusNode();
  final FocusNode startTimeFocus = FocusNode();
  final FocusNode endTimeFocus = FocusNode();
  final FocusNode eventLocationNode = FocusNode();
  final FocusNode descriptionNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _formBloc = FormBloc();
  }

  @override
  void dispose() {
    _formBloc.close();
    eventNameFocus.dispose();
    eventLocationNode.dispose();
    startTimeFocus.dispose();
    endTimeFocus.dispose();
    descriptionNode.dispose();
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
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(AppImages.arrowBackImage),
                    ),
                    Text("Event", style: textStyle(fontSize: 22)),
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
                            child: Image.asset("assets/images/EventIcon.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Event Name",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.eventName != current.eventName,
                            builder: (context, state) {
                              return TextFormField(
                                validator: Validation.textValidation(
                                  "Event Name",
                                ),
                                focusNode: eventNameFocus,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeEventName(eventName: value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(startTimeFocus);
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter event name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Start Date and Time",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            builder: (context, state) {
                              return TextFormField(
                                validator: Validation.dateTimeValidation(
                                  "StartDateTime",
                                ),
                                focusNode: startTimeFocus,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeStartDateTime(startTime: value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(endTimeFocus);
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "12 Dec 2022, 10:40 pm",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "End Date and Time",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            builder: (context, state) {
                              return TextFormField(
                                validator: Validation.dateTimeValidation(
                                  "EndDataTime",
                                ),
                                focusNode: endTimeFocus,
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeEndDateTime(endTime: value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(eventLocationNode);
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "12 Dec 2022, 10:40 pm",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Event Location",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            builder: (context, state) {
                              return TextFormField(
                                validator: Validation.textValidation(
                                  "Location",
                                ),
                                focusNode: eventLocationNode,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeEventLocation(eventLocation: value),
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(descriptionNode);
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter location",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            builder: (context, state) {
                              return TextFormField(
                                focusNode: descriptionNode,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeDescription(description: value),
                                  );
                                },

                                maxLines: 3,

                                decoration: InputDecoration(
                                  hintText: "Enter any details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
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
                                        EventQrGenerationButton(),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .09),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
