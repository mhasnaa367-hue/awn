import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
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
  bool _obscureConfirm = true;
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Appbar(title: l.forgetPasswordTitle),

                  SvgPicture.asset(AssetsManager.forgetpassword3,
                      width: context.wp(70)),

                  SizedBox(height: context.hp(5)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: Text(
                      l.verifyPasswordDesc,
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
                      hintText: l.newPassword,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l.enterNewPassword;
                    }
                    if (value.length < 8) {
                      return l.passwordMin8;
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

                  SizedBox(height: context.hp(2.5)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: CustomTextField(
                      hintText: l.confirmPassword,
                      controller: _confirmController,
                      obscureText: _obscureConfirm,
                      prefixIcon: Icons.lock_outline_rounded,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l.enterNewPassword;
                        }
                        if (value != _passwordController.text) {
                          return l.passwordMatch;
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: ColorsManager.darkGray,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: context.hp(6)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: GradientButton(
                      text: l.save,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, RoutesManager.homeScreen);
                        }
                      },
                    ),
                  ),

                  SizedBox(height: context.hp(2.5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}