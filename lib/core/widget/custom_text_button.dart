import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors_manager.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomTextButton({super.key,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          decoration: TextDecoration.underline,
          decorationColor: ColorsManager.green,
          color: ColorsManager.green,
        ),
      ),
    );
    ;
  }
}
