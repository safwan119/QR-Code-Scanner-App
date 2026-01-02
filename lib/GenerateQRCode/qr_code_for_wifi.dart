import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/bloc/form/form_state.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_button.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../route/routes_name.dart';

class QrCodeForWifi extends StatefulWidget {
  const QrCodeForWifi({super.key});

  @override
  State<QrCodeForWifi> createState() => _QrCodeForWifiState();
}

class _QrCodeForWifiState extends State<QrCodeForWifi> {
  late FormBloc _formBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _formBloc = FormBloc();
    super.initState();
  }

  @override
  void dispose() {
    _formBloc.close();
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
                    Text("Wi-Fi", style: textStyle(fontSize: 22)),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .13),
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
                            child: Image.asset("assets/images/WifiIcon.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Network",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.networkName != current.networkName,
                            builder: (context, state) {
                              return TextFormField(
                                validator: Validation.textValidation(
                                  "NetworkName",
                                ),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeNetworkName(networkName: value),
                                  );
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Enter network name",
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
                              "Password",
                              style: textStyle(fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<FormBloc, FormsState>(
                            buildWhen: (previous, current) =>
                                previous.networkPassword !=
                                current.networkPassword,
                            builder: (context, state) {
                              return TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator:
                                    Validation.wifiPasswordLengthValidation(
                                      "Wifi Password",
                                    ),
                                onChanged: (value) {
                                  context.read<FormBloc>().add(
                                    ChangeNetworkPassword(
                                      networkPassword: value,
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter password",
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
                                ShortMessage.showErrorMessage(
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
                                ShortMessage.showErrorMessage(
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
                                        WifiQrGenerationButton(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
