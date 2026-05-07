import 'package:awn/core/resources/colors_manager.dart';
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
                top: 50,
                right: 25,
                child: InkWell(
                  onTap: onSkip,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.inter(
                        color: ColorsManager.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: SvgPicture.asset(
                    image,
                    height: 260,
                    width: 260,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: ColorsManager.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
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
