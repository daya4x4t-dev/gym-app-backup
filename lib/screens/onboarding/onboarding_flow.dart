import 'package:flutter/material.dart';
import '../../utils/onboarding_service.dart';
import '../app_onboarding/app_onboarding_flow.dart';
import 'gender_step.dart';
import 'age_step.dart';
import 'height_step.dart';
import 'weight_step.dart';

/// Wraps the four onboarding steps in a PageView.
/// On the final step's "Complete Setup" the user is
/// marked as onboarded and sent to the Intro screen.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  late final PageController _pageCtrl;
  int _currentPage = 0;
  static const _totalPages = 4;

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await OnboardingService.markOnboardingDone();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppOnboardingFlow()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Progress Dots ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPages, (i) {
                  final active = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: active ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFFE53935)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),

            // ── Step content ─────────────────────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (p) => setState(() => _currentPage = p),
                children: [
                  GenderStep(onContinue: _next),
                  AgeStep(onContinue: _next),
                  HeightStep(onContinue: _next),
                  WeightStep(onContinue: _finish),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
