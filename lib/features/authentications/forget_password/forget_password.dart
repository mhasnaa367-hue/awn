import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/bar_forgetpass.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: BarForgetpass(),
            ),

            SvgPicture.asset(AssetsManager.forgetpassword1),

            const SizedBox(height: 50),

            Text(
              "Please Enter Your Email Address To\nReceive a Verification Code",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: ColorsManager.lightgray,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 50),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
              ),
            ),

            const SizedBox(height: 90),

            GradientButton(
              width: 300,
              text: "Send",
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
