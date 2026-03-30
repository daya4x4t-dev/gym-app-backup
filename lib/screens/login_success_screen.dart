import 'package:flutter/material.dart';
import '../utils/auth_background.dart';
import '../utils/onboarding_service.dart';
import 'onboarding/onboarding_flow.dart';
import 'app_onboarding/app_onboarding_flow.dart';

class LoginSuccessScreen extends StatefulWidget {
  const LoginSuccessScreen({super.key});

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {

  @override
  void initState() {
    super.initState();
    _startDelay(); // 🔥 start timer when screen loads
  }

  Future<void> _startDelay() async {
    // ⏳ wait 5 seconds
    await Future.delayed(const Duration(seconds: 3));

    // 🔍 check if new user
    final isNew = await OnboardingService.isNewUser();

    // ⚠️ important safety check
    if (!mounted) return;

    // 🚀 navigate based on user type
    if (isNew) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OnboardingFlow()),
            (_) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AppOnboardingFlow()),
            (_) => false,
      );
    }
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

              // ✅ Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Title
              const Text(
                'Login Successful',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // ✅ Subtitle
              Text(
                "Welcome back! Let's start your workout.",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // 🔥 Optional UX improvement
              const Text(
                "Ready to throttle your fitness?",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}