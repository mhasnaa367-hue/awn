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

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    bool isPassword = false,
    bool? obscure,
    VoidCallback? onToggle,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? (obscure ?? true) : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: ColorsManager.darkGray),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              (obscure ?? true)
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: ColorsManager.darkGray,
            ),
            onPressed: onToggle,
          )
              : null,
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: ColorsManager.darkGray,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      SizedBox(height: 50),

                      _buildField(
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

                      SizedBox(height: 16),

                      // Email
                      _buildField(
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

                      SizedBox(height: 16),

                      // Password
                      _buildField(
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

                      SizedBox(height: 16),

                      _buildField(
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
                            Navigator.pushNamed(context, RoutesManager.homeScreen);
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
                                color: Colors.black87,
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