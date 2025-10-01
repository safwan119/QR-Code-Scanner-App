import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class GenerateButton extends StatelessWidget {
 final String title;
 final VoidCallback? onTap;
 const GenerateButton({super.key, required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.amber.shade600,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.akayaTelivigala(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
