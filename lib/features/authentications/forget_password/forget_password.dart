import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Appbar(title: l.forgetPasswordTitle),

            SvgPicture.asset(AssetsManager.forgetpassword1),

            const SizedBox(height: 50),

            Text(
              l.forgetPasswordDesc,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                hintText: l.email,
                prefixIcon: Icons.email_outlined,
              ),
            ),

            const SizedBox(height: 90),

            GradientButton(
              width: 300,
              text: l.send,
              onTap: () {
                Navigator.pushNamed(context, RoutesManager.mailSent);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}