import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../bloc/form/form_bloc.dart';
import '../bloc/form/form_state.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../route/routes_name.dart';

class QrCodeForPhone extends StatefulWidget {
  const QrCodeForPhone({super.key});

  @override
  State<QrCodeForPhone> createState() => _QrCodeForPhoneState();
}

class _QrCodeForPhoneState extends State<QrCodeForPhone> {
  late FormBloc _formBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _formBloc = FormBloc();
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
      body: BlocProvider(
        create: (context) => _formBloc,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(AppImages.arrowBackImage),
                  ),
                  Text("Phone", style: textStyle(fontSize: 22)),
                ],
              ),
              SizedBox(height: AppSize.getHeight(13.0)),
              BlocListener<FormBloc, FormsState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == Status.initial) {
                    ShortMessage.showSuccessMessage(context, "Loading..");
                  }
                  if (state.status == Status.error) {
                    ShortMessage.showErrorMessage(context, state.message);
                  }
                  if (state.status == Status.complete) {
                    ShortMessage.showSuccessMessage(context, state.message);
                    Navigator.pushNamed(
                      context,
                      RoutesName.qrCodeScreen,
                      arguments: state.url,
                    );
                  }
                },
                child: BlocBuilder<FormBloc, FormsState>(
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: GenerateQRCodeUsingChannel(
                        title: "Phone Number",
                        validator: Validation.phoneNumberValidity(
                          "Phone Number",
                        ),
                        onChange: (value) {
                          context.read<FormBloc>().add(
                            ChangePhoneNumber(phoneNumber: value ?? ""),
                          );
                        },
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<FormBloc>().add(
                              PhoneQrGenerationButton(),
                            );
                          }
                        },
                        image: "assets/images/PhoneIcon.png",
                        hintText: "+92xxxxxxxxx",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
