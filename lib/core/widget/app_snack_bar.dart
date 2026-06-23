// CORE WIDGET
// One place that shows a message to the user with a nice, consistent look.
// Use it anywhere like this:
//
//   AppSnackBar.show(context, "File uploaded", isSuccess: true);
//   AppSnackBar.show(context, "Something went wrong", isSuccess: false);
//
// Green with a check for success, red with a warning for errors.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors_manager.dart';

class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    required bool isSuccess,
  }) {
    final color = isSuccess ? ColorsManager.green : ColorsManager.red;
    final icon = isSuccess ? Icons.check_circle : Icons.error;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
