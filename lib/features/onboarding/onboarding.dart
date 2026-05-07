import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/features/authentications/login/login_screen.dart';
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
                title: "Learn Smarter with One Snap!",
                description:
                    "Take a picture and let the app tell you what it’s all about",
                onSkip: _goToLogin,
              ),
              OnboardPage(
                image: AssetsManager.onboarding2,
                title: "Instant Understanding",
                description:
                    "Get the main idea of any page in seconds no reading needed",
                onSkip: _goToLogin,
              ),
              OnboardPage(
                image: AssetsManager.onboarding3,
                title: "Learn More, Watch More!",
                description:
                    "Discover short YouTube videos that explain your image topic clearly",
                onSkip: _goToLogin,
              ),
            ],
          ),

          Positioned(
            bottom: 80,
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
            bottom: 190,
            right: 20,
            left: isLastPage ? 20 : null,
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
                height: 50,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ColorsManager.green, ColorsManager.lightgreen],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  isLastPage ? "Get Started" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
