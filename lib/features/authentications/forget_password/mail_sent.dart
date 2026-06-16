import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
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
      body: Column(
        children: [
          Appbar(title: l.forgetPasswordTitle),

          const SizedBox(height: 30),

          SvgPicture.asset(AssetsManager.forgetpassword2),

          const SizedBox(height: 50),

          Text(
            l.mailSentDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 50),

          OtpInputField(
            onCompleted: (otp) {},
          ),

          const SizedBox(height: 60),

          CustomTextButton(
            text: l.resendCode,
            onPressed: () {},
          ),

          const SizedBox(height: 50),

          GradientButton(
            width: 350,
            text: l.verify,
            onTap: () {
              Navigator.pushNamed(context, RoutesManager.verifyPassword);
            },
          ),
        ],
      ),
    );
  }
}