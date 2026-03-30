import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Main
  static const Color background = Color(0xFF0D0D0D);
  static const Color cardBg = Color(0x0DFFFFFF); // white 5%
  static const Color fieldBg = Color(0xFF1A1A1A);
  static const Color gradientStart = Color(0xFF8B0000);
  static const Color gradientEnd = Color(0xFFFF2E2E);
  static const Color accentRed = Color(0xFFE53935);
  static const Color accentRedBright = Color(0xFFFF2E2E);
  static const Color accentRedDark = Color(0xFFC62828);

  // Colors - Backgrounds & Text
  static const Color bgLight = Color(0xFFF5F6FA);
  static const Color bgLightGrey = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textDarkAlt = Color(0xFF1C1C2E);
  static const Color textGrey = Color(0xFF757575);
  static const Color textGreyAlt = Color(0xFF8A8FA3);
  static const Color textGreyLight = Color(0xFF9E9E9E);

  // Colors - Functional/Stats
  static const Color purplePrimary = Color(0xFF7B61FF);
  static const Color greenAccent = Color(0xFF4CAF50);
  static const Color orangeCalories = Color(0xFFFF7043);
  static const Color blueWater = Color(0xFF42A5F5);
  static const Color tealCarbs = Color(0xFF26A69A);

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
  );

  // Text Styles
  static const TextStyle h1 = TextStyle(
    color: textDark,
    fontSize: 24,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    color: textDark,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle body = TextStyle(
    color: textGrey,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subtext = TextStyle(
    color: textGreyLight,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  // Glassmorphism card decoration
  static BoxDecoration glassCard({double radius = 24}) => BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      );

  // Smooth fade + slide page route
  static PageRouteBuilder<T> fadeSlideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeCurve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        );
        final slideCurve = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: fadeCurve,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.06, 0),
              end: Offset.zero,
            ).animate(slideCurve),
            child: child,
          ),
        );
      },
    );
  }
}
