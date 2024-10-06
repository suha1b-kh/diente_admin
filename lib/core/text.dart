import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text customText(BuildContext context, String text, Color color, double size,
    FontWeight fontWeight) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}
