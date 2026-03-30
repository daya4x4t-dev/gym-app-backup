import 'package:flutter/material.dart';
import '../utils/auth_background.dart';
import '../utils/app_theme.dart';
import '../utils/onboarding_service.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  Future<void> _handleLoginNow(BuildContext context) async {
    // Mark this device/session as a new user so onboarding
    // is triggered after the very next login.
    await OnboardingService.setNewUser();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      AppTheme.fadeSlideRoute(const LoginScreen()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Celebration Icon ──────────────────────────────────────────
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.gradientStart.withValues(alpha: 0.2),
                      AppTheme.gradientEnd.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.accentRed.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    '🎉',
                    style: TextStyle(fontSize: 48),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ── Title ─────────────────────────────────────────────────────
              const Text(
                'Account Created\nSuccessfully',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // ── Subtitle ──────────────────────────────────────────────────
              Text(
                'Your fitness journey starts now!',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // ── Primary Button ─────────────────────────────────────────────
              CustomButton(
                text: 'LOGIN NOW',
                onTap: () => _handleLoginNow(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
