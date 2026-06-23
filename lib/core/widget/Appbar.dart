import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/colors_manager.dart';
import '../utils/responsive.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white : ColorsManager.green;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.wp(4), vertical: context.hp(4)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: color,
                fontSize: context.sp(20),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                color: ColorsManager.green,
                size: context.r(35),
              ),
            ),
          ),
          if (actions != null)
            Align(
              alignment: Alignment.centerRight,
              child: actions!,
            ),
        ],
      ),
    );
  }
}