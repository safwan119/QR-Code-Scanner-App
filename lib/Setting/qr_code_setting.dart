import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/Message/flutter_toast_message.dart';
import 'package:qr_code_scanner/constants/shared_apk_and_qr_data.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/state/camera_control_provider.dart';
import 'package:qr_code_scanner/state/device_id_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeSetting extends StatefulWidget {
  const QrCodeSetting({super.key});

  @override
  State<QrCodeSetting> createState() => _QrCodeSettingState();
}

class _QrCodeSettingState extends State<QrCodeSetting> {
  final firebaseDatabaseReference = FirebaseDatabase.instance.ref("Rating");
  final dbRef = FirebaseDatabase.instance.ref("Switch");
  bool _isDataLoaded = false;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      final settingControlProvider = Provider.of<CameraControlProvider>(
        context,
        listen: false,
      );
      settingControlProvider.switchStoringData(context);
      settingControlProvider.ratingDataStore(context);
      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingControlProvider = Provider.of<CameraControlProvider>(context);
    final idProvider = Provider.of<DeviceIdProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/ArrowBackPic.png"),
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
                  leading: Image.asset("assets/images/VibrateIcon.png"),
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
                  trailing: Switch(
                    activeThumbColor: Colors.amber.shade600,
                    value: settingControlProvider.vibrateSwitch,
                    onChanged: (value) async {
                      settingControlProvider.setVibrateSwitch(value);
                      await idProvider.initializeDeviceId();
                      dbRef.child(idProvider.deviceId).set({
                        "VibrateSwitch": settingControlProvider.vibrateSwitch,
                        "BeepSwitch": settingControlProvider.beepSwitch,
                      });
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
                  leading: Image.asset("assets/images/BeepIcon.png"),
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
                  trailing: Switch(
                    activeThumbColor: Colors.amber.shade600,
                    value: settingControlProvider.beepSwitch,
                    onChanged: (value) async {
                      settingControlProvider.setBeepSwitch(value);
                      await idProvider.initializeDeviceId();
                      dbRef.child(idProvider.deviceId).set({
                        "VibrateSwitch": settingControlProvider.vibrateSwitch,
                        "BeepSwitch": settingControlProvider.beepSwitch,
                      });
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
                  image: "assets/images/RateIcon.png",
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
                  image: "assets/images/ShareIcon.png",
                  title: "Share",
                  subtitle: "Share app with others.",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: InkWell(
                onTap: () async {
                  final Uri uri = Uri.parse(
                    "https://sites.google.com/view/qr-code-app--privacy-policy/home",
                  );
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                  if (!await launchUrl(uri)) {
                    throw 'Could not launch $uri';
                  }
                },
                child: ReusableCard(
                  image: "assets/images/PrivacyIcon.png",
                  title: "Privacy Policy",
                  subtitle: "Follow our policies that benefits you.",
                ),
              ),
            ),
          ],
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
            final settingControlProvider = Provider.of<CameraControlProvider>(
              context,
              listen: false,
            );
            return AlertDialog(
              scrollable: true,
              shadowColor: Colors.amber.shade700,
              title: Center(
                child: Text("Rate Us", style: TextStyle(color: Colors.white)),
              ),
              backgroundColor: Colors.black,
              content: StarRating(
                borderColor: Colors.white,
                rating: settingControlProvider.rating,
                allowHalfRating: false,
                onRatingChanged: (rating) {
                  setDialogState(() {
                    settingControlProvider.setRating(rating);
                  });
                },
                size: 40,
                color: Colors.amber,
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
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.amber.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          final idProvider = Provider.of<DeviceIdProvider>(
                            context,
                            listen: false,
                          );
                          await idProvider.initializeDeviceId();
                          if (idProvider.deviceId != null) {
                            firebaseDatabaseReference
                                .child(idProvider.deviceId)
                                .once()
                                .then((snapshot) {
                                  final data = snapshot.snapshot.value as Map?;
                                  if (data != null && data.isNotEmpty) {
                                    FlutterToastMessage().toastMessage(
                                      "You have already submitted the review",
                                    );
                                  } else {
                                    firebaseDatabaseReference
                                        .child(idProvider.deviceId)
                                        .set({
                                          "rating":
                                              settingControlProvider.rating,
                                        })
                                        .then((value) {
                                          FlutterToastMessage().toastMessage(
                                            "Submit Successfully",
                                          );
                                        })
                                        .onError((error, stackTrace) {
                                          FlutterToastMessage().toastMessage(
                                            "an error during submitting review",
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
