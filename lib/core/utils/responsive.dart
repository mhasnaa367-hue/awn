// CORE UTIL
// Small, dependency-free helpers that make the UI adapt to any screen size.
//
// Usage in a widget's build method:
//
//   final r = context.responsive;   // or use the shortcuts directly
//   width: context.wp(80),          // 80% of the screen width
//   height: context.hp(5),          // 5% of the screen height
//   fontSize: context.sp(16),       // a font size that scales with the screen
//
// And to keep content readable on tablets / desktop / web, wrap the body in
// a `ResponsiveCenter`, which limits how wide the content can grow and
// centers it.
import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  Size get _size => MediaQuery.of(this).size;

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  // Phones are usually < 600 logical px on their shortest side.
  bool get isTablet => _size.shortestSide >= 600;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  // Percentage-of-screen helpers.
  double wp(double percent) => screenWidth * percent / 100;
  double hp(double percent) => screenHeight * percent / 100;

  // Scale a value relative to a 375px-wide reference design, clamped so it
  // never gets too small on tiny phones or absurdly large on big screens.
  double r(double value) {
    final scale = (screenWidth / 375).clamp(0.85, 1.4);
    return value * scale;
  }

  // Like [r] but a touch gentler — good for font sizes so text stays tidy.
  double sp(double value) {
    final scale = (screenWidth / 375).clamp(0.9, 1.3);
    return value * scale;
  }
}

/// Centers its [child] and caps how wide it can grow. On phones it just fills
/// the available width (minus side padding); on tablets / wide windows the
/// content stays a comfortable, readable width instead of stretching edge to
/// edge.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 560,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
