import 'package:flutter/material.dart';
import 'package:qr_code_scanner/HomeScreen/home_screen.dart';
import 'package:qr_code_scanner/QRCodeGenerate/generate_qr_code.dart';
import 'package:qr_code_scanner/QRCodesHistory/qr_code_history.dart';
import 'package:qr_code_scanner/constants/app_size.dart';
import 'package:qr_code_scanner/presentation/widgets/image/image_path.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<Widget> screens = [GenerateQrCode(), QrCodeHistory(), HomeScreen()];
  var itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Transform.scale(
        scale: 1.8,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          shape: CircleBorder(),
          onPressed: () {
            setState(() {
              itemIndex = 2;
            });
          },
          child: Image.asset(AppImages.QrButtonImage, fit: BoxFit.cover),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.qr_code_2_rounded, "Generate", 0),
              const SizedBox(width: 40),
              _buildNavItem(Icons.history, "History", 1),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: itemIndex,
        children: screens.map((screen) {
          int screenIndex = screens.indexOf(screen);
          return screenIndex == itemIndex ? screen : Container();
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(IconData iconData, String label, int index) {
    final isSelected = itemIndex == index;
    final color = isSelected ? Colors.amber : Colors.white;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              itemIndex = index;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: color, size: 24),
              Text(label, style: TextStyle(color: color, fontSize: 12)),
              SizedBox(height: AppSize.h0_5),
              if (isSelected)
                Container(
                  height: 3,
                  width: 43,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
              else
                SizedBox(height: AppSize.h0_5),
            ],
          ),
        ),
      ),
    );
  }
}
