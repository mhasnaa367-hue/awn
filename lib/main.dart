import 'package:awn/config/theme/theme.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/features/authentications/login/login_screen.dart';
import 'package:awn/features/authentications/register/register_screen.dart';
import 'package:awn/features/onboarding/onboarding.dart';
import 'package:awn/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'core/widget/OnboardPage.dart';

void main() {
  runApp(Awn());
}

class Awn extends StatelessWidget {
  const Awn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesManager.Splashscreen,
      onGenerateRoute: RoutesManager.getRoute,
      theme: lightTheme,
      darkTheme: DarkTheme,
      themeMode: ThemeMode.system,
    );
  }
}