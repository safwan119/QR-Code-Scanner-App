import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:qr_code_scanner/constants/shared_apk_and_qr_data.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:qr_code_scanner/core/util/short_message.dart';
import 'package:qr_code_scanner/presentation/controllers/qr_camera_controller.dart';
import 'package:qr_code_scanner/presentation/controllers/user_id_controller.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';
import 'package:qr_code_scanner/presentation/widgets/url/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

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
      final settingController=Get.find<QrCameraController>();
      settingController.switchStoringData(context);
      settingController.ratingDataStore(context);
      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingController=Get.find<QrCameraController>();
    final userId=Get.find<UserIdController>();
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            InkWell(
              onTap: () =>Get.back(),
              child: Image.asset(ImagePath.arrowBackImage),
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
                  leading: Image.asset(ImagePath.vibrationIconImage),
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
                  trailing:
                  Obx(()=>Switch(
                    activeColor: Colors.amber.shade600,
                    value:settingController.vibrateSwitch.value,
                    onChanged: (value) async {
                      settingController.setVibrateSwitch(value);
                      await userId.initializeDeviceId();
                      dbRef.child(userId.deviceId.value).set({
                        "VibrateSwitch":settingController.vibrateSwitch,
                        "BeepSwitch":settingController.beepSwitch,
                      });
                    },
                  ),),

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
                  leading: Image.asset(ImagePath.beepIconImage),
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
                  trailing: Obx(()=>Switch(
                    activeColor: Colors.amber.shade600,
                    value:settingController.beepSwitch.value,
                    onChanged: (value) async {
                      settingController.setBeepSwitch(value);
                      await userId.initializeDeviceId();
                      dbRef.child(userId.deviceId.value).set({
                        "VibrateSwitch":settingController.vibrateSwitch.value,
                        "BeepSwitch":settingController.beepSwitch.value,
                      });
                    },
                  ),),


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
                  image:ImagePath.ratingIconImage,
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
                  image: ImagePath.shareIconImage,
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
                    AppUrls.privacyUrl,
                  );
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                  if (!await launchUrl(uri)) {
                    throw 'Could not launch $uri';
                  }
                },
                child: ReusableCard(
                  image:ImagePath.privacyIconImage,
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
            final settingController=Get.find<QrCameraController>();
            return AlertDialog(
              scrollable: true,
              shadowColor: Colors.amber.shade700,
              title: Center(
                child: Text("Rate Us", style: TextStyle(color: Colors.white)),
              ),
              backgroundColor: Colors.black,
              content:Obx(()=>StarRating(
                borderColor: Colors.white,
                rating:settingController.rating.value,
                allowHalfRating: false,
                onRatingChanged: (rating) {
                  setDialogState(() {
                    settingController.setRating(rating);
                  });
                },
                size: 40,
                color: Colors.amber,
              ),),

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
                        onPressed: () =>Get.back(),
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
                          final userIdController=Get.find<UserIdController>();
                          await userIdController.initializeDeviceId();
                          if (userIdController.deviceId.value != null) {
                            firebaseDatabaseReference
                                .child(userIdController.deviceId.value)
                                .once()
                                .then((snapshot) {
                                  final data = snapshot.snapshot.value as Map?;
                                  if (data != null && data.isNotEmpty) {
                                    ShortMessage.showErrorMessage("You have already submitted the review");
                                  } else {
                                    firebaseDatabaseReference
                                        .child(userIdController.deviceId.value)
                                        .set({
                                          "rating":
                                              settingController.rating.value,
                                        })
                                        .then((value) {
                                          ShortMessage.showSuccessMessage("Submit Successfully");
                                        })
                                        .onError((error, stackTrace) {
                                          ShortMessage.showSuccessMessage("An error during submitting the review");
                                        });
                                  }
                                });
                          }
                          Get.back();
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
