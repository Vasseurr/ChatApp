import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/text_constants.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      required this.title,
      this.fontWeight,
      this.fontSize,
      this.color});

  String title;
  FontWeight? fontWeight;
  double? fontSize;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.comfortaa(
        fontSize: fontSize ?? TextConstants.highFontSize,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? Colors.black,
      ),
    );
  }
}
