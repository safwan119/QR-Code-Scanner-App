import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_bloc.dart';
import 'package:qr_code_scanner/bloc/form/form_event.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/validators.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

import '../ReusableWidget/generate_qr_code_using_channel.dart';
import '../bloc/form/form_state.dart';
import '../core/enum/status.dart';
import '../core/util/short_message.dart';
import '../route/routes_name.dart';

class QrCodeForWebsite extends StatefulWidget {
  const QrCodeForWebsite({super.key});

  @override
  State<QrCodeForWebsite> createState() => _QrCodeForWebsiteState();
}

class _QrCodeForWebsiteState extends State<QrCodeForWebsite> {
  late FormBloc _formBloc;
  final formKey = GlobalKey<FormState>();

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
                  Text("Website", style: textStyle(fontSize: 22)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .13),
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
                  buildWhen: (previous, current) => previous.url != current.url,
                  builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: GenerateQRCodeUsingChannel(
                        title: "Website Url",
                        onChange: (value) {
                          context.read<FormBloc>().add(
                            ChangeWebsiteUrl(url: value ?? ""),
                          );
                        },
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<FormBloc>().add(UrlQrGenerationButton());
                          }
                        },
                        validator: Validation.websiteUrlValidity("website url"),
                        image: "assets/images/WebsiteIcon.png",
                        hintText: "Enter www.qrcode.com",
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
