import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.height = 50,
    this.width = 300,
  });

  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: isDark ? ColorsManager.green : ColorsManager.col,
        borderRadius: BorderRadius.circular(30),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(
          color: isDark ? ColorsManager.green : ColorsManager.lightBlack,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? ColorsManager.white : ColorsManager.darkGray,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: isDark ? ColorsManager.white : ColorsManager.darkGray,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: isDark ? ColorsManager.lightBlack : ColorsManager.lightwhite,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: isDark ? ColorsManager.green : ColorsManager.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: isDark ? ColorsManager.darkGray : ColorsManager.col,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: isDark ? ColorsManager.green : ColorsManager.darkGray,
            ),
          ),
        ),
      ),
    );
  }
}
