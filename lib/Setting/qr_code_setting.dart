import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/Message/flutter_toast_message.dart';
import 'package:qr_code_scanner/SharedPreference/user_id_services.dart';
import 'package:qr_code_scanner/constants/text_style.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeSetting extends StatefulWidget {
  const QrCodeSetting({super.key});

  @override
  State<QrCodeSetting> createState() => _QrCodeSettingState();
}

class _QrCodeSettingState extends State<QrCodeSetting> {
  final firebaseDatabaseReference=FirebaseDatabase.instance.ref("Rating");
  final dbRef=FirebaseDatabase.instance.ref("Switch");
  bool vibrateSwitch = false;
  bool beepSwitch = true;
  late double _rating=0.0;
  @override
  void initState(){
    super.initState();
    switchStoringData();
    ratingDataStore();
  }
  Future<void> switchStoringData() async {
    UserIdServices userIdServices=UserIdServices();
    final deviceId=await userIdServices.getOrCreateUserId();
     await dbRef.child(deviceId).once().then((snapshot){
       final data = snapshot.snapshot.value as Map?;
       if(data!=null){
         setState(() {
           vibrateSwitch=data["VibrateSwitch"]??false;
           beepSwitch=data["BeepSwitch"]??false;
         });
       }
     });

  }
  Future<void> ratingDataStore() async {
    UserIdServices userIdServices=UserIdServices();
    final deviceId=await userIdServices.getOrCreateUserId();
    await firebaseDatabaseReference.child(deviceId).once().then((snapshot){
      final data = snapshot.snapshot.value as Map?;
      if(data!=null){
        final dynamic ratingValue = data["rating"];

        setState(() {
          if (ratingValue is num) {
            _rating = ratingValue.toDouble();
          } else {
            _rating = 0.0;
          }
        });
        print("The rating in this id is :$_rating");
      }
    });

  }
  Future<void> shareApkFile(BuildContext context) async {
     String fileName = 'app-release.apk';
    final tempDir = await getTemporaryDirectory();
     final ByteData data = await rootBundle.load("assets/files/app-release.apk");
     final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

     final fileToShare = File('${tempDir.path}/$fileName');
    try {
      final xFile = XFile(
        fileToShare.path,
      );
      await fileToShare.writeAsBytes(bytes, flush: true);
      await SharePlus.instance.share(
      ShareParams( files: [xFile],
        text: 'Here is the APK of my Flutter app.',)
      );

    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Error sharing APK. File might be missing in assets: $e'),
          ),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            InkWell(onTap: ()=>Navigator.pop(context),
                child: Image.asset("assets/images/ArrowBackPic.png")),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Setting",
                style:textStyle(fontSize: 30,isColor: true,color: Colors.amber.shade600)
              ),
            ),
            SizedBox(height: 20,),
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
                    value: vibrateSwitch,
                    onChanged: (value) async {

                      setState(() {

                        vibrateSwitch = value;
                        beepSwitch=!value;
                      });
                      UserIdServices userIdServices=UserIdServices();
                     final deviceId= await userIdServices.getOrCreateUserId();
                      dbRef.child(deviceId).set({
                        "VibrateSwitch":vibrateSwitch,
                        "BeepSwitch":beepSwitch,
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
                    value: beepSwitch,
                    onChanged: (value) async {

                      setState(() {
                        beepSwitch=value;
                        vibrateSwitch = !value;
                      });
                      UserIdServices userIdServices=UserIdServices();
                      final deviceId= await userIdServices.getOrCreateUserId();
                      dbRef.child(deviceId).set({
                        "VibrateSwitch":vibrateSwitch,
                        "BeepSwitch":beepSwitch,
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
                style:textStyle(fontSize: 30,color: Colors.amber.shade600,isColor: true)
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: InkWell(onTap: ()=>_showDialogBox(_rating),
                child: ReusableCard(
                  image: "assets/images/RateIcon.png",
                  title: "Rate Us",
                  subtitle: "Your best reward to us.",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: InkWell(onTap: ()=>shareApkFile(context),
                child: ReusableCard(
                  image: "assets/images/ShareIcon.png",
                  title: "Share",
                  subtitle: "Share app with others.",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: InkWell(onTap: () async {
                final Uri uri=Uri.parse("https://sites.google.com/view/qr-code-app--privacy-policy/home");
                await launchUrl(uri,mode: LaunchMode.externalApplication);
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
  Future<void> _showDialogBox(double currentRating)async{
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(
        builder: (BuildContext dialogContext, StateSetter setDialogState) {
          return AlertDialog(scrollable: true,shadowColor: Colors.amber.shade700,
            title: Center(child: Text("Rate Us",style: TextStyle(color: Colors.white),)),
            backgroundColor: Colors.black,
            content:  StarRating(
              borderColor: Colors.white,
              rating: currentRating,
              allowHalfRating: false,
              onRatingChanged: (rating) =>
                  setDialogState(() => currentRating = rating),
              size: 40,
              color: Colors.amber,
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.white12,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(color: Colors.white),)),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.amber.shade700,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        onPressed: () async {
                      UserIdServices userIdServices=UserIdServices();
                      final deviseId=await userIdServices.getOrCreateUserId();
                      if(deviseId!=null) {
                        firebaseDatabaseReference.child(deviseId).once().then((snapshot){
                          final data = snapshot.snapshot.value as Map?;
                          if (data != null && data.isNotEmpty) {
                            FlutterToastMessage().toastMessage("You have already submitted the review");
                          }
                          else{
                        firebaseDatabaseReference.child(deviseId).set({
                          "rating": currentRating,
                        }).then((value) {
                          FlutterToastMessage().toastMessage(
                              "Submit Successfully");
                        }).onError((error, stackTrace) {
                          FlutterToastMessage().toastMessage(
                              "Any error accour during submitting review");
                        });}
                          });
                      }
                            Navigator.pop(context);
                        }, child: Text("Submit",style: TextStyle(color: Colors.black),)),
                  ),
                ],
              ),

            ],
          );
        }
      );
    });
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
