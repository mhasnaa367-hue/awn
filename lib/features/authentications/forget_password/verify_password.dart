import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/bar_forgetpass.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/colors_manager.dart';

class VerifyPassword extends StatefulWidget {
  const VerifyPassword({super.key});

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: BarForgetpass(),
              ),

              SvgPicture.asset(
                AssetsManager.forgetpassword3,
              ),
              const SizedBox(height: 50),

              Text(
                "Your New Password Must Be Different\nFrom Previously Used Password",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: ColorsManager.lightgray,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  hintText: "New password",
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Password";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: ColorsManager.darkGray,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: "Confirm password",
                controller: _passwordController,
                obscureText: _obscurePassword,
                prefixIcon: Icons.lock_outline_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Password";
                  }
                  if (value.length < 8) {
                    return "Password must be match the";
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: ColorsManager.darkGray,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 50,),
              GradientButton(
                  width: 320,
                  text: "Save", onTap: () {
                Navigator.pushNamed(context, RoutesManager.homeScreen);
              })
            ],
          ),
        ),
      ),
    );
  }
}