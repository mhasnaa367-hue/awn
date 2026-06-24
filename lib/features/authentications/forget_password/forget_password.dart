import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/custom_text_field.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = "/forget_password";

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  // Our ready-to-use auth repository (built by the helper).
  final AuthRepository _auth = createAuthRepository();

  bool _isLoading = false; // true while we wait for the server

  final _emailController = TextEditingController();

  // Sends the forgot-password request and reacts to the result.
  Future<void> _sendResetEmail() async {
    // 1) Check the form first.
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    try {
      // 2) Call the API. The server emails a 6-digit reset code.
      await _auth.forgotPassword(email: email);

      if (!mounted) return;
      // 3) Success -> go to the "mail sent" screen, carrying the email so the
      //    next steps can reset the password.
      Navigator.pushNamed(context, RoutesManager.mailSent, arguments: email);
    } on ServerException catch (e) {
      // 4) The server said no (email not found, etc.).
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      // 5) Always stop the loading spinner.
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                      controller: _emailController,
                      hintText: l.email,
                      prefixIcon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l.enterEmail;
                        }
                        if (!value.contains("@")) {
                          return l.validEmail;
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: context.hp(10)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(10)),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : GradientButton(
                            text: l.send,
                            onTap: _sendResetEmail,
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
