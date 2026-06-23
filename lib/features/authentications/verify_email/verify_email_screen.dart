// Email verification (OTP) screen.
// Shown right after Register. It asks the server to send a 6-digit code,
// lets the user type it in, verifies it, and can resend a new code.
import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/custom_text_button.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/core/widget/otp_input_field.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final AuthRepository _auth = createAuthRepository();

  String _code = '';
  bool _isVerifying = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    // Ask the server to send the first code as soon as we arrive.
    WidgetsBinding.instance.addPostFrameCallback((_) => _sendInitialOtp());
  }

  Future<void> _sendInitialOtp() async {
    try {
      await _auth.sendOtp();
    } on ServerException catch (_) {
      // Ignore here (e.g. "already verified"); the user can still resend.
    }
  }

  Future<void> _verify() async {
    if (_code.length < 6) return;
    setState(() => _isVerifying = true);
    try {
      await _auth.verifyEmail(code: _code);
      if (!mounted) return;
      AppSnackBar.show(context, AppLocalizations.of(context)!.emailVerified,
          isSuccess: true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesManager.homeScreen,
        (route) => false,
      );
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  Future<void> _resend() async {
    setState(() => _isResending = true);
    try {
      await _auth.resendOtp();
      if (!mounted) return;
      AppSnackBar.show(context, AppLocalizations.of(context)!.otpResent,
          isSuccess: true);
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            child: Column(
              children: [
                Appbar(title: l.verifyEmailTitle),
                SizedBox(height: context.hp(4)),
                Icon(
                  Icons.mark_email_read_outlined,
                  size: context.r(90),
                  color: ColorsManager.green,
                ),
                SizedBox(height: context.hp(5)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: Text(
                    l.verifyEmailDesc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: colorScheme.onSurface,
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
                      _verify();
                    },
                  ),
                ),
                SizedBox(height: context.hp(4)),
                _isResending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : CustomTextButton(text: l.resendCode, onPressed: _resend),
                SizedBox(height: context.hp(4)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                  child: _isVerifying
                      ? const Center(child: CircularProgressIndicator())
                      : GradientButton(text: l.verify, onTap: _verify),
                ),
                SizedBox(height: context.hp(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
