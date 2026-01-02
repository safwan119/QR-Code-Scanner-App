import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_bloc.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_event.dart';
import 'package:qr_code_scanner/bloc/camera/change_camera_state.dart';
import 'package:qr_code_scanner/bloc/preference/preference_bloc.dart';
import 'package:qr_code_scanner/bloc/preference/preference_event.dart';
import 'package:qr_code_scanner/bloc/preference/preference_state.dart';
import 'package:qr_code_scanner/constants/shared_apk_and_qr_data.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import 'package:qr_code_scanner/presentation/widgets/url/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeSetting extends StatefulWidget {
  const QrCodeSetting({super.key});

  @override
  State<QrCodeSetting> createState() => _QrCodeSettingState();
}

class _QrCodeSettingState extends State<QrCodeSetting> {
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref("Rating");
  final dbRef = FirebaseDatabase.instance.ref("Switch");

  @override
  void initState() {
    super.initState();
    context.read<PreferenceBloc>().add(InitializeDeviceId());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferenceBloc, PreferenceState>(
      listenWhen: (previous, current) => previous != current.userDeviceId,
      listener: (context, state) {
        final _deviceId = state.userDeviceId;

        context.read<ChangeCameraBloc>().add(
          SwitchStoringDataChange(deviceID: _deviceId),
        );
        context.read<ChangeCameraBloc>().add(
          RatingDataStoreChange(deviceID: _deviceId),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(AppImages.arrowBackImage),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Setting",
                  style: textStyle(
                    fontSize: 30,
                    isColor: true,
                    color: Colors.amber.shade600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    leading: Image.asset(AppImages.vibrationIconImage),
                    title: Text(
                      "Vibrate",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Vibration when scan is done",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: BlocBuilder<PreferenceBloc, PreferenceState>(
                      builder: (context, preState) {
                        return BlocBuilder<ChangeCameraBloc, ChangeCameraState>(
                          buildWhen: (previous, current) =>
                              previous.vibrateSwitch != current.vibrateSwitch ||
                              previous.beepSwitch != current.beepSwitch,
                          builder: (context, state) {
                            return Switch(
                              activeThumbColor: Colors.amber.shade600,
                              value: state.vibrateSwitch,
                              onChanged: (value) async {
                                context.read<ChangeCameraBloc>().add(
                                  SetVibrateSwitch(vibrateValue: value),
                                );
                                dbRef.child(preState.userDeviceId).set({
                                  "VibrateSwitch": state.vibrateSwitch,
                                  "BeepSwitch": state.beepSwitch,
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ListTile(
                    leading: Image.asset(AppImages.beepIconImage),
                    title: Text(
                      "Beep",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Beep when scan is done",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: BlocBuilder<PreferenceBloc, PreferenceState>(
                      buildWhen: (previous, current) =>
                          previous.userDeviceId != current.userDeviceId,
                      builder: (context, preState) {
                        return BlocBuilder<ChangeCameraBloc, ChangeCameraState>(
                          buildWhen: (previous, current) =>
                              previous.vibrateSwitch != current.vibrateSwitch ||
                              previous.beepSwitch != current.beepSwitch,
                          builder: (context, state) {
                            return Switch(
                              activeThumbColor: Colors.amber.shade600,
                              value: state.beepSwitch,
                              onChanged: (value) async {
                                context.read<ChangeCameraBloc>().add(
                                  SetBeepSwitch(beepValue: value),
                                );
                                dbRef.child(preState.userDeviceId).set({
                                  "VibrateSwitch": state.vibrateSwitch,
                                  "BeepSwitch": state.beepSwitch,
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Support",
                  style: textStyle(
                    fontSize: 30,
                    color: Colors.amber.shade600,
                    isColor: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: InkWell(
                  onTap: () => _showDialogBox(),
                  child: ReusableCard(
                    image: AppImages.ratingIconImage,
                    title: "Rate Us",
                    subtitle: "Your best reward to us.",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: InkWell(
                  onTap: () => SharedApkAndQrData.shareApkFile(context),
                  child: ReusableCard(
                    image: AppImages.shareIconImage,
                    title: "Share",
                    subtitle: "Share app with others.",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: InkWell(
                  onTap: () async {
                    final Uri uri = Uri.parse(AppUrls.privacyUrl);
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                    if (!await launchUrl(uri)) {
                      throw 'Could not launch $uri';
                    }
                  },
                  child: ReusableCard(
                    image: AppImages.privacyIconImage,
                    title: "Privacy Policy",
                    subtitle: "Follow our policies that benefits you.",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialogBox() async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext dialogContext, StateSetter setDialogState) {
            return AlertDialog(
              scrollable: true,
              shadowColor: Colors.amber.shade700,
              title: Center(
                child: Text("Rate Us", style: TextStyle(color: Colors.white)),
              ),
              backgroundColor: Colors.black,
              content: BlocBuilder<ChangeCameraBloc, ChangeCameraState>(
                builder: (context, state) {
                  return StarRating(
                    borderColor: Colors.white,
                    rating: state.rating,
                    allowHalfRating: false,
                    onRatingChanged: (rating) {
                      setDialogState(() {
                        context.read<ChangeCameraBloc>().add(
                          SetRatingChange(rating: rating),
                        );
                      });
                    },
                    size: 40,
                    color: Colors.amber,
                  );
                },
              ),

              actions: [
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: BlocBuilder<PreferenceBloc, PreferenceState>(
                        buildWhen: (previous, current) =>
                            previous.userDeviceId != current.userDeviceId,
                        builder: (context, preState) {
                          return BlocBuilder<
                            ChangeCameraBloc,
                            ChangeCameraState
                          >(
                            buildWhen: (previous, current) =>
                                previous.rating != current.rating,
                            builder: (context, state) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.amber.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () async {
                                  if (preState.userDeviceId != null) {
                                    firebaseDatabaseReference
                                        .child(preState.userDeviceId)
                                        .once()
                                        .then((snapshot) {
                                          final data =
                                              snapshot.snapshot.value as Map?;
                                          if (data != null && data.isNotEmpty) {
                                            ShortMessage.showErrorMessage(
                                              context,
                                              "You have already submitted the review",
                                            );
                                          } else {
                                            firebaseDatabaseReference
                                                .child(preState.userDeviceId)
                                                .set({"rating": state.rating})
                                                .then((value) {
                                                  ShortMessage.showSuccessMessage(
                                                    context,
                                                    "Submit Successfully",
                                                  );
                                                })
                                                .onError((error, stackTrace) {
                                                  ShortMessage.showSuccessMessage(
                                                    context,
                                                    "An error during submitting the review",
                                                  );
                                                });
                                          }
                                        });
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ReusableCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const ReusableCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
