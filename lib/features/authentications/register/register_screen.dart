import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/login_header.dart';
import 'package:awn/core/widget/gradient_button.dart';
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

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

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
            fontSize: 14,
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

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              LoginHeader(
                title: "Welcome\nBack",
                text: "Please register to continue",
              ),
              Positioned(
                top: 250,
                left: 20,
                right: 20,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),

                      _buildField(
                        context,
                        controller: _usernameController,
                        hint: "Username",
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Username";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildField(
                        context,
                        controller: _emailController,
                        hint: "Email",
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Email";
                          }
                          if (!value.contains("@")) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildField(
                        context,
                        controller: _passwordController,
                        hint: "Password",
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
                            return "Please Enter Your Password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 chars";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildField(
                        context,
                        controller: _confirmController,
                        hint: "Confirm password",
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
                            return "Please Confirm Your Password";
                          }
                          if (value != _passwordController.text) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30),

                      GradientButton(
                        text: "Sign Up",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(
                                context, RoutesManager.homeScreen);
                          }
                        },
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesManager.loginsrceen);
                              },
                              child: Text(
                                "Sign in",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}