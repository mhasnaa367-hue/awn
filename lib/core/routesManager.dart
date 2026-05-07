import 'package:awn/features/authentications/forget_password/forget_password.dart';
import 'package:awn/features/homeScreen/home_screen.dart';
import 'package:awn/features/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';

import '../features/authentications/login/login_screen.dart';
import '../features/authentications/register/register_screen.dart';
import '../features/splash/splash_screen.dart';

class RoutesManager {
  static const String Splashscreen = "/splash_screen";
  static const String loginsrceen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String onboarding = "/onboard_page";
  static const String forgetPassword = "/forget_password";
  static const String homeScreen = "/home_screen";

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
    }
  }
}
