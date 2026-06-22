import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
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
    try {
      // 2) Call the API. The server expects: email.
      print("Sending reset email...");
      await _auth.forgotPassword(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      // 3) Success -> go to the "mail sent" screen.
      Navigator.pushNamed(context, RoutesManager.mailSent);
    } on ServerException catch (e) {
      // 4) The server said no (email not found, etc.).
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.errModel.errorMessage)),
      );
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

            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
            ),

            const SizedBox(height: 90),

            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GradientButton(
              width: 300,
              text: l.send,
              onTap: _sendResetEmail,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}