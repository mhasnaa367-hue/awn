import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/login_header.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/colors_manager.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/register_screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Our ready-to-use auth repository (built by the helper).
  final AuthRepository _auth = createAuthRepository();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false; // true while we wait for the server

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  // Sends the register request and reacts to the result.
  Future<void> _register() async {
    // 1) Check the form first.
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // 2) Call the API. The server expects: name, email, password.
      await _auth.register(
        name: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      // 3) Success -> verify the email next (upload needs a verified email).
      Navigator.pushNamed(context, RoutesManager.verifyEmail);
    } on ServerException catch (e) {
      // 4) The server said no (email taken, weak password, etc.).
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      // 5) Always stop the loading spinner.
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _buildField(
      BuildContext context, {
        required TextEditingController controller,
        required String hint,
        required IconData prefixIcon,
        bool isPassword = false,
        bool? obscure,
        VoidCallback? onToggle,
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
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? (obscure ?? true) : false,
        keyboardType: keyboardType,
        style: TextStyle(color: colorScheme.onSurface),
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: colorScheme.onSurface.withOpacity(0.5),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              (obscure ?? true)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            onPressed: onToggle,
          )
              : null,
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
                LoginHeader(
                  title: l.registerTitle,
                  text: l.pleaseRegister,
                ),
                // Pull the form up so it overlaps the wavy header a little.
                Transform.translate(
                  offset: Offset(0, -context.hp(4)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.wp(6)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            context,
                            controller: _usernameController,
                            hint: l.username,
                            prefixIcon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l.enterUsername;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.hp(2)),
                          _buildField(
                            context,
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
                          _buildField(
                            context,
                            controller: _passwordController,
                            hint: l.password,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscure: _obscurePassword,
                            onToggle: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
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
                          SizedBox(height: context.hp(2)),
                          _buildField(
                            context,
                            controller: _confirmController,
                            hint: l.confirmPassword,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscure: _obscureConfirm,
                            onToggle: () {
                              setState(() {
                                _obscureConfirm = !_obscureConfirm;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l.confirmPasswordError;
                              }
                              if (value != _passwordController.text) {
                                return l.passwordsNotMatch;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: context.hp(4)),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : GradientButton(
                                  text: l.register,
                                  onTap: _register,
                                ),
                          SizedBox(height: context.hp(2.5)),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l.alreadyHaveAccount,
                                  style: GoogleFonts.inter(
                                    fontSize: context.sp(14),
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesManager.loginsrceen);
                                  },
                                  child: Text(
                                    l.signIn,
                                    style: GoogleFonts.inter(
                                      fontSize: context.sp(14),
                                      color: ColorsManager.green,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorsManager.green,
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
