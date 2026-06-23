import 'package:awn/core/API/auth_setup.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/token_storage.dart';
import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _auth = createAuthRepository();

  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool("seenOnboarding") ?? false;

    String route;
    if (TokenStorage.isLoggedIn) {
      // We have a saved token, but it may be expired. Actually use it once:
      // - if the access token is valid OR the refresh token renews it, getMe
      //   succeeds and we keep the user signed in.
      // - if BOTH tokens are dead, the interceptor clears them, so
      //   isLoggedIn flips to false below and we send the user to login.
      try {
        await _auth.getMe();
      } catch (_) {
        // network error -> tokens are left intact (handled by the check below);
        // auth error -> the interceptor already cleared the tokens.
      }
      route = TokenStorage.isLoggedIn
          ? RoutesManager.homeScreen
          : RoutesManager.loginsrceen;
    } else if (seenOnboarding) {
      route = RoutesManager.loginsrceen;
    } else {
      route = RoutesManager.onboarding;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(15)),
          child: Image.asset(AssetsManager.logo, width: context.wp(55)),
        ),
      ),
    );
  }
}
