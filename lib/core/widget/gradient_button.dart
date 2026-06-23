import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors_manager.dart';
import '../utils/responsive.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cap the width so fixed values passed on small screens never overflow.
      width: width == null
          ? double.infinity
          : width!.clamp(0.0, context.screenWidth - context.wp(8)),
      height: context.r(height).clamp(48.0, 64.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.green,
            ColorsManager.lightgreen,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: context.sp(18),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}