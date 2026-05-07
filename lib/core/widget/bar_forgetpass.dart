import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors_manager.dart';

class BarForgetpass extends StatelessWidget {
  const BarForgetpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: ColorsManager.green,
            size: 35,
          ),
        ),
        SizedBox(width: 60,),
        Text(
          "Forget Password",
          style: GoogleFonts.inter(
            color: ColorsManager.green,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
