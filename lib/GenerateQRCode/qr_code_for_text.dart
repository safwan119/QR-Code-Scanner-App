import 'package:flutter/material.dart';
import 'package:qr_code_scanner/bloc/form/form_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/core/enum/status.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../bloc/form/form_state.dart';
import '../constants/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../route/routes_name.dart';

class QrCodeForText extends StatefulWidget {
  const QrCodeForText({super.key});

  @override
  State<QrCodeForText> createState() => _QrCodeForTextState();
}

class _QrCodeForTextState extends State<QrCodeForText> {
  late FormBloc _formBloc;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _formBloc = FormBloc();
  }

  void dispose() {
    super.dispose();
    _formBloc.close();
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
                  Text("Text", style: textStyle(fontSize: 22)),
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
                      arguments: state.text,
                    );
                  }
                },
                child: BlocBuilder<FormBloc, FormsState>(
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: GenerateQRCodeUsingChannel(
                        title: "Text",
                        onChange: (value) {
                          context.read<FormBloc>().add(
                            ChangeText(text: value ?? ""),
                          );
                        },
                        validator: Validation.textValidation("text"),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<FormBloc>().add(
                              TextQrGenerationButton(),
                            );
                          }
                        },
                        image: "assets/images/TextIcon.png",
                        hintText: "Enter text",
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
