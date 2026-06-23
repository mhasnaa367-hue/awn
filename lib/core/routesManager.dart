import 'package:awn/features/authentications/forget_password/forget_password.dart';
import 'package:awn/features/authentications/forget_password/verify_password.dart';
import 'package:awn/features/homeScreen/camera/CameraScreen.dart';
import 'package:awn/features/homeScreen/main_layout/favorite/favorite.dart';
import 'package:awn/features/homeScreen/main_layout/history/history.dart';
import 'package:awn/features/homeScreen/main_layout/home/home_screen.dart';
import 'package:awn/features/homeScreen/main_layout/result/result.dart';
import 'package:awn/features/homeScreen/main_layout/settings/profile.dart';
import 'package:awn/features/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';

import '../features/authentications/forget_password/mail_sent.dart';
import '../features/authentications/login/login_screen.dart';
import '../features/authentications/register/register_screen.dart';
import '../features/authentications/verify_email/verify_email_screen.dart';
import '../features/splash/splash_screen.dart';

class RoutesManager {
  static const String Splashscreen = "/splash_screen";
  static const String loginsrceen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String onboarding = "/onboard_page";
  static const String forgetPassword = "/forget_password";
  static const String homeScreen = "/home_screen";
  static const String mailSent = "/mail_sent";
  static const String verifyPassword = "/verify_password";
  static const String favorite = "/favorite";
  static const String history = "/history";
  static const String profile = "/profile";
  static const String camera = "/camera_screen";
  static const String result = "/result";
  static const String verifyEmail = "/verify_email";

  static Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case registerScreen:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
      case loginsrceen:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
        }
      case Splashscreen:
        {
          return CupertinoPageRoute(builder: (context) => SplashScreen());
        }
      case onboarding:
        {
          return CupertinoPageRoute(builder: (context) => OnboardingScreen());
        }
      case forgetPassword:
        {
          return CupertinoPageRoute(builder: (context) => ForgetPassword());
        }
        case homeScreen:
        {
          return CupertinoPageRoute(builder: (context) => HomeScreen());
        }
        case mailSent:
        {
          return CupertinoPageRoute(builder: (context) => MailSent());
        }
        case verifyPassword:
        {
          return CupertinoPageRoute(builder: (context) => VerifyPassword());
        }
        case favorite:
        {
          return CupertinoPageRoute(builder: (context) => Favorite());
        }
        case history:
        {
          return CupertinoPageRoute(builder: (context) => History());
        }
        case profile:
        {
          return CupertinoPageRoute(builder: (context) => Profile());
        }
      case camera:
        {
          return CupertinoPageRoute(builder: (context) => CameraScreen());
        }
        case result:
        {
          // The id of the document to show is passed as the route argument.
          final documentId = settings.arguments is String
              ? settings.arguments as String
              : null;
          return CupertinoPageRoute(
            builder: (context) => Result(documentId: documentId),
          );
        }
        case verifyEmail:
        {
          return CupertinoPageRoute(builder: (context) => const VerifyEmailScreen());
        }
    }
    return null;
  }
}
