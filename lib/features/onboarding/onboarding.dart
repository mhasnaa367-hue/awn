import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/features/authentications/login/login_screen.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/widget/OnboardPage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  Future<void> _goToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              OnboardPage(
                image: AssetsManager.onboarding1,
                title: l.onboard1Title,
                description: l.onboard1Desc,
                onSkip: _goToLogin,
              ),
              OnboardPage(
                image: AssetsManager.onboarding2,
                title: l.onboard2Title,
                description: l.onboard2Desc,
                onSkip: _goToLogin,
              ),
              OnboardPage(
                image: AssetsManager.onboarding3,
                title: l.onboard3Title,
                description: l.onboard3Desc,
                onSkip: _goToLogin,
              ),
            ],
          ),

          Positioned(
            bottom: context.hp(10),
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: ColorsManager.gray,
                  activeDotColor: ColorsManager.green,
                  expansionFactor: 2,
                  dotWidth: 8,
                  dotHeight: 8,
                  spacing: 15,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: context.hp(23),
            right: context.wp(5),
            left: isLastPage ? context.wp(5) : null,
            child: GestureDetector(
              onTap: () {
                if (isLastPage) {
                  _goToLogin();
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: context.r(50),
                width: isLastPage ? double.infinity : context.wp(32),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsManager.green, ColorsManager.lightgreen],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  isLastPage ? l.getStarted : l.next,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.sp(20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}