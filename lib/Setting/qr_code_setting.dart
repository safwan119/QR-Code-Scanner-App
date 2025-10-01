import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrCodeSetting extends StatefulWidget {
  const QrCodeSetting({super.key});

  @override
  State<QrCodeSetting> createState() => _QrCodeSettingState();
}

class _QrCodeSettingState extends State<QrCodeSetting> {
  bool isSwitch1 = false;
  bool isSwitch2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Image.asset("assets/images/ArrowBackPic.png"),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Setting",
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.amber.shade600,
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                ),
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
                    value: isSwitch1,
                    onChanged: (value) {
                      isSwitch1 = !isSwitch1;
                      setState(() {});
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
                    value: isSwitch2,
                    onChanged: (value) {
                      isSwitch2 = !isSwitch2;
                      setState(() {});
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
                style: GoogleFonts.akayaTelivigala(
                  color: Colors.amber.shade600,
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: ReusableCard(
                image: "assets/images/RateIcon.png",
                title: "Rate Us",
                subtitle: "Your best reward to us.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: ReusableCard(
                image: "assets/images/ShareIcon.png",
                title: "Share",
                subtitle: "Share app with others.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: ReusableCard(
                image: "assets/images/PrivacyIcon.png",
                title: "Rate Us",
                subtitle: "Follow our policies that benefits you.",
              ),
            ),
          ],
        ),
      ),
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
