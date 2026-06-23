import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            child: Column(
              children: [
                Appbar(title: l.forgetPasswordTitle),

                SvgPicture.asset(AssetsManager.forgetpassword1,
                    width: context.wp(70)),

                SizedBox(height: context.hp(5)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: Text(
                    l.forgetPasswordDesc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: context.hp(5)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: CustomTextField(
                    hintText: l.email,
                    prefixIcon: Icons.email_outlined,
                  ),
                ),

                SizedBox(height: context.hp(10)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(10)),
                  child: GradientButton(
                    text: l.send,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesManager.mailSent);
                    },
                  ),
                ),

                SizedBox(height: context.hp(2.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}