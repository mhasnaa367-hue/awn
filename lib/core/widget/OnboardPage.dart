import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback? onSkip;

  const OnboardPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: const BoxDecoration(
            color: ColorsManager.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: context.hp(6),
                right: context.wp(6),
                child: InkWell(
                  onTap: onSkip,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.wp(4.5), vertical: context.hp(1)),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.inter(
                        color: ColorsManager.green,
                        fontWeight: FontWeight.w600,
                        fontSize: context.sp(16),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.hp(5),
                      left: context.wp(5),
                      right: context.wp(5)),
                  child: SvgPicture.asset(
                    image,
                    height: context.wp(60).clamp(180.0, 320.0),
                    width: context.wp(60).clamp(180.0, 320.0),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: context.hp(6)),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: context.sp(24),
                    color: ColorsManager.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.hp(2.5)),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: context.sp(18),
                    color: ColorsManager.lightgray,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
