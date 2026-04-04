import 'package:flutter/material.dart';
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