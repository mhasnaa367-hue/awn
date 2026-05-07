import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/core/widget/login_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/resources/colors_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                title: "Welcome \n Back",
                text: "Please sign in to continue",
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
                      Text(
                        "Sign In",
                        style: GoogleFonts.inter(
                          color: ColorsManager.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),

                      SizedBox(height: 20),

                      // Email
                      Container(
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: ColorsManager.darkGray,
                            ),
                            hintText: "Email",
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorsManager.darkGray,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: InputBorder.none,
                          ),
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
                      ),

                      SizedBox(height: 16),

                      // Password
                      Container(
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
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: ColorsManager.darkGray,
                            ),
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
                            hintText: "Password",
                            hintStyle: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorsManager.darkGray,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: InputBorder.none,
                          ),
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
                      ),

                      SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    _rememberMe = val!;
                                  });
                                },
                                activeColor: ColorsManager.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Text(
                                "Remember me",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: ColorsManager.darkGray,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RoutesManager.forgetPassword,
                              );
                            },
                            child: Text(
                              "Forget Password?",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: ColorsManager.green,
                                color: ColorsManager.green,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Sign In Button
                      GradientButton(
                        text: "Sign in",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            print("Email: $email");
                            print("Password: $password");

                            Navigator.pushNamed(
                                context, RoutesManager.homeScreen);
                          }
                        },
                      ),

                      SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: ColorsManager.green,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Or"),
                          ),
                          Expanded(
                            child: Divider(
                              color: ColorsManager.green,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AssetsManager.google,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.homeScreen,
                            );
                          },
                          child: Text(
                            "Continue as Guest",
                            style: GoogleFonts.inter(
                              fontSize: 14,
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
                              "Don't have an account? ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesManager.registerScreen,
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: ColorsManager.green,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
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