import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../bloc/form/form_bloc.dart';
import '../bloc/form/form_state.dart';
import '../constants/app_size.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../route/routes_name.dart';

class QrCodeForEmail extends StatefulWidget {
  const QrCodeForEmail({super.key});

  @override
  State<QrCodeForEmail> createState() => _QrCodeForEmailState();
}

class _QrCodeForEmailState extends State<QrCodeForEmail> {
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
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(AppImages.arrowBackImage),
                    ),
                    Text("Email", style: textStyle(fontSize: 22)),
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
                        arguments: state.qrResult,
                      );
                    }
                  },
                  child: BlocBuilder<FormBloc, FormsState>(
                    buildWhen: (previous, current) =>
                        previous.email != current.email,
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: GenerateQRCodeUsingChannel(
                          title: "Email",
                          validator: Validation.emailValidity("Email"),
                          onChange: (value) {
                            context.read<FormBloc>().add(
                              ChangeEmailField(email: state.email),
                            );
                          },
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<FormBloc>().add(
                                EmailQrGenerationButton(),
                              );
                            }
                          },
                          image: "assets/images/EmailIcon.png",
                          hintText: "Enter email address",
                        ),
                      );
                    },
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
