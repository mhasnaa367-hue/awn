import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/widget/bar_forgetpass.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/features/authentications/forget_password/mail_sent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
          SvgPicture.asset(AssetsManager.forgetpassword1),
          SizedBox(height: 50),
          Text(
            "Please Enter Your Email Address To\n      Receive a Verification Code",
            style: GoogleFonts.inter(
              color: ColorsManager.lightgray,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50,),
          CustomTextField(hintText: "Email",prefixIcon: Icons.email_outlined)
        ],
      ),
    );
  }
}
