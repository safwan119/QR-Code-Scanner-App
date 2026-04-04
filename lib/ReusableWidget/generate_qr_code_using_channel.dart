import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'generate_button.dart';

class GenerateQRCodeUsingChannel extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String image;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  const GenerateQRCodeUsingChannel({
    super.key,
    this.onChange,
    this.validator,
    required this.title,
    required this.onTap,
    required this.image,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(color: Colors.amber.shade600),
            bottom: BorderSide(color: Colors.amber.shade600),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Center(child: Image.asset(image)),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: GoogleFonts.akayaTelivigala(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: validator,
                onChanged: onChange,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
              GenerateButton(title: "Generate QR Code", onTap: onTap),
              SizedBox(height: MediaQuery.of(context).size.height * .03),
            ],
          ),
        ),
      ),
    );
  }
}
