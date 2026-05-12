import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/bar_forgetpass.dart';
import 'package:awn/core/widget/custom_text_button.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widget/otp_input_field.dart';

class MailSent extends StatelessWidget {
  const MailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: BarForgetpass(),
          ),
          SvgPicture.asset(AssetsManager.forgetpassword2),
          SizedBox(height: 50),
          Text(
            "Please Enter The 4 Digit Code\n         Sent To Your Email",
            style: GoogleFonts.inter(
              color: ColorsManager.lightgray,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50),
          OtpInputField(
            onCompleted: (otp) {},
          ),
          SizedBox(height: 60,),
          CustomTextButton(text: "Resend code", onPressed: () {}),
          SizedBox(height: 50,),
          GradientButton(
              width: 350,
              text: "Verify", onTap: () {
            Navigator.pushNamed(context, RoutesManager.verifyPassword);
          })
        ],
      ),
    );
  }
}
