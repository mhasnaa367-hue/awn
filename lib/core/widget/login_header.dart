import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors_manager.dart';
import '../utils/responsive.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String text;
  const LoginHeader({super.key,required this.title,required this.text});

  @override
  Widget build(BuildContext context) {
    // Height adapts to the screen but is clamped so it never dominates a small
    // phone or look lost on a big tablet.
    final height = context.hp(36).clamp(240.0, 340.0);

    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorsManager.green, ColorsManager.lightgreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: context.wp(7), top: context.hp(7)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: ColorsManager.white,
                  fontSize: context.sp(32),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.hp(1.2)),
              Text(
                text,
                style: GoogleFonts.inter(
                  color: ColorsManager.white,
                  fontSize: context.sp(16),
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);

    var firstControlPoint = Offset(size.width / 4, size.height - 100);
    var firstEndPoint = Offset(size.width / 2, size.height - 50);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
