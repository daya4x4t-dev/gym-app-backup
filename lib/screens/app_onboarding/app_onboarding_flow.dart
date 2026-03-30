import 'package:flutter/material.dart';
import '../main_shell.dart';

/// 3-slide full-screen motivational onboarding shown after every login
/// and after completing the user-details onboarding for new users.
class AppOnboardingFlow extends StatefulWidget {
  const AppOnboardingFlow({super.key});

  @override
  State<AppOnboardingFlow> createState() => _AppOnboardingFlowState();
}

class _AppOnboardingFlowState extends State<AppOnboardingFlow> {
  final _pageCtrl = PageController();
  int _page = 0;

  static final _slides = <_SlideData>[
    _SlideData(
      gradientColors: [Color(0xCC000000), Color(0x99000000), Color(0x00000000)],
      gradientStops: [0.0, 0.55, 1.0],
      title: 'WELCOME TO\nX-ADAPTER',
      subtitle: 'YOUR PERSONAL FITNESS\nJOURNEY STARTS HERE.',
      buttonLabel: 'GET STARTED',
    ),
    _SlideData(
      gradientColors: [Color(0xDD000000), Color(0x998B0000), Color(0x00000000)],
      gradientStops: [0.0, 0.6, 1.0],
      title: 'TRANSFORM YOUR\nBODY. TRANSFORM\nYOUR LIFE',
      subtitle:
          'AI-GENERATED WORKOUT ROUTINES BASED ON YOUR\nBODY TYPE, EXPERIENCE LEVEL AND GOALS.',
      buttonLabel: 'NEXT',
    ),
    _SlideData(
      gradientColors: [Color(0xEE000000), Color(0xBB000000), Color(0x22000000)],
      gradientStops: [0.0, 0.5, 1.0],
      title: "YOU'RE NOT ALONE\nIN THIS JOURNEY",
      subtitle:
          'JOIN CHALLENGES, CONNECT WITH TRAINERS AND STAY\nMOTIVATED WITH A SUPPORTIVE FITNESS COMMUNITY.',
      buttonLabel: 'GO TO HOME',
    ),
  ];

  void _next() {
    if (_page < _slides.length - 1) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goHome();
    }
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (_) => false,
    );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── PageView ──────────────────────────────────────────────────────
          PageView.builder(
            controller: _pageCtrl,
            onPageChanged: (p) => setState(() => _page = p),
            itemCount: _slides.length,
            itemBuilder: (_, index) {
              final slide = _slides[index];
              return _SlideScreen(slide: slide);
            },
          ),

          // ── Overlay: button + dots (always on top) ────────────────────────
          Positioned(
            left: 24,
            right: 24,
            bottom: 48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE53935),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _slides[_page].buttonLabel,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Page dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (i) {
                    final active = i == _page;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFFE53935)
                            : Colors.white38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Data model for a single slide.
class _SlideData {
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final String title;
  final String subtitle;
  final String buttonLabel;

  const _SlideData({
    required this.gradientColors,
    required this.gradientStops,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
  });
}

/// Individual slide widget — full-screen background + gradient + text.
class _SlideScreen extends StatelessWidget {
  final _SlideData slide;

  const _SlideScreen({required this.slide});

  static const _bgImage =
      'assets/images/eb4cefe0c24c3e3010394ae4bfd3c9b8.jpg';

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          _bgImage,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),

        // Gradient overlay (bottom-up, per slide)
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: slide.gradientColors,
              stops: slide.gradientStops,
            ),
          ),
        ),

        // Content anchored to bottom
        Positioned(
          left: 24,
          right: 24,
          bottom: 148, // above the button+dots layer
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title — bold, white, uppercase
              Text(
                slide.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                slide.subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
