import 'package:flutter/material.dart';

class SplashScreenWidget extends StatelessWidget {
  final Color? bgColor;
  final String image;

  const SplashScreenWidget({
    super.key,
    required this.image,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Center(
        child: Image.asset(image),
      ),
    );
  }
}
