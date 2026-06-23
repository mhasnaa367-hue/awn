import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/custom_text_button.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/core/widget/login_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/colors_manager.dart';
import 'package:awn/l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Our ready-to-use auth repository (built by the helper).
  final AuthRepository _auth = createAuthRepository();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false; // true while we wait for the server

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Sends the login request and reacts to the result.
  Future<void> _login() async {
    // 1) Check the form first.
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // 2) Call the API.
      await _auth.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      // 3) Success -> go to the home screen.
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesManager.homeScreen,
        (route) => false,
      );
    } on ServerException catch (e) {
      // 4) The server said no (wrong password, etc.) -> show the message.
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
    _passwordController.dispose();
    super.dispose();
  }

  // A rounded, bordered input that matches the app's auth style.
  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorsManager.green, width: 1),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: TextStyle(color: colorScheme.onSurface),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: colorScheme.onSurface.withOpacity(0.5)),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: context.sp(14),
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          filled: true,
          fillColor: colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            child: Column(
              children: [
                LoginHeader(title: l.welcomeBack, text: l.pleaseSignIn),
                Transform.translate(
                  offset: Offset(0, -context.hp(4)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: context.hp(1.5)),
                            child: Text(
                              l.signIn,
                              style: GoogleFonts.inter(
                                color: ColorsManager.green,
                                fontWeight: FontWeight.w500,
                                fontSize: context.sp(32),
                              ),
                            ),
                          ),
                          SizedBox(height: context.hp(1)),
                          _field(
                            controller: _emailController,
                            hint: l.email,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
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
                          SizedBox(height: context.hp(2)),
                          _field(
                            controller: _passwordController,
                            hint: l.password,
                            prefixIcon: Icons.lock_outline,
                            obscure: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: colorScheme.onSurface.withOpacity(0.5),
                              ),
                              onPressed: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l.enterPassword;
                              }
                              if (value.length < 6) {
                                return l.passwordLength;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.hp(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (val) {
                                        setState(() => _rememberMe = val!);
                                      },
                                      activeColor: ColorsManager.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        l.rememberMe,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: context.sp(13),
                                          color: colorScheme.onSurface.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextButton(
                                text: l.forgetPassword,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesManager.forgetPassword);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: context.hp(2)),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GradientButton(text: l.signIn, onTap: _login),
                          SizedBox(height: context.hp(3)),
                          Row(
                            children: [
                              Expanded(child: Divider(color: ColorsManager.green, thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: context.wp(3)),
                                child: Text(l.or, style: TextStyle(color: colorScheme.onSurface)),
                              ),
                              Expanded(child: Divider(color: ColorsManager.green, thickness: 1)),
                            ],
                          ),
                          SizedBox(height: context.hp(2.5)),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(AssetsManager.google,
                                  height: context.r(40), width: context.r(40)),
                            ),
                          ),
                          SizedBox(height: context.hp(2.5)),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RoutesManager.homeScreen);
                              },
                              child: Text(
                                l.continueAsGuest,
                                style: GoogleFonts.inter(
                                  fontSize: context.sp(14),
                                  color: ColorsManager.green,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l.dontHaveAccount,
                                  style: GoogleFonts.inter(
                                      fontSize: context.sp(14), color: colorScheme.onSurface),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, RoutesManager.registerScreen);
                                  },
                                  child: Text(
                                    l.signUp,
                                    style: GoogleFonts.inter(
                                      fontSize: context.sp(14),
                                      color: ColorsManager.green,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: context.hp(2)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
