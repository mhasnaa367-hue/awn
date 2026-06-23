import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/custom_text_button.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widget/otp_input_field.dart';

class MailSent extends StatelessWidget {
  const MailSent({super.key});

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

                SizedBox(height: context.hp(3)),

                SvgPicture.asset(AssetsManager.forgetpassword2,
                    width: context.wp(70)),

                SizedBox(height: context.hp(5)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: Text(
                    l.mailSentDesc,
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
                  padding: EdgeInsets.symmetric(horizontal: context.wp(4)),
                  child: OtpInputField(onCompleted: (otp) {}),
                ),

                SizedBox(height: context.hp(6)),

                CustomTextButton(text: l.resendCode, onPressed: () {}),

                SizedBox(height: context.hp(5)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: GradientButton(
                    text: l.verify,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesManager.verifyPassword);
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