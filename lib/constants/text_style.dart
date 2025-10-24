import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle({required double fontSize,Color? color,bool isColor=false}) {
  return GoogleFonts.akayaTelivigala(
    color:isColor?color:Colors.white,
    fontWeight: FontWeight.w300,
    fontSize:fontSize,
  );
}
