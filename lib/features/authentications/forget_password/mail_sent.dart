import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/custom_text_button.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widget/otp_input_field.dart';

class MailSent extends StatefulWidget {
  const MailSent({super.key, this.email});

  // The email the reset code was sent to (carried from ForgetPassword).
  final String? email;

  @override
  State<MailSent> createState() => _MailSentState();
}

class _MailSentState extends State<MailSent> {
  final AuthRepository _auth = createAuthRepository();

  String _code = '';
  bool _isResending = false;

  // Move on to choose a new password, carrying email + code.
  void _continue() {
    final l = AppLocalizations.of(context)!;
    if (_code.length < 6) {
      AppSnackBar.show(context, l.verifyEmailDesc, isSuccess: false);
      return;
    }
    Navigator.pushNamed(
      context,
      RoutesManager.verifyPassword,
      arguments: {'email': widget.email, 'code': _code},
    );
  }

  Future<void> _resend() async {
    final l = AppLocalizations.of(context)!;
    if (widget.email == null) return;
    setState(() => _isResending = true);
    try {
      await _auth.forgotPassword(email: widget.email!);
      if (!mounted) return;
      AppSnackBar.show(context, l.otpResent, isSuccess: true);
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

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
                    l.verifyEmailDesc,
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
                  child: OtpInputField(
                    length: 6,
                    onChanged: (v) => setState(() => _code = v),
                    onCompleted: (v) {
                      _code = v;
                      _continue();
                    },
                  ),
                ),

                SizedBox(height: context.hp(6)),

                _isResending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : CustomTextButton(text: l.resendCode, onPressed: _resend),

                SizedBox(height: context.hp(5)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: GradientButton(text: l.verify, onTap: _continue),
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
