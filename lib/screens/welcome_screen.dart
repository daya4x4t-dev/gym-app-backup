import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gradient_button.dart';
import '../widgets/social_login_button.dart';

// ─────────────────────────────────────────────
//  Brand palette — one place to update colors
// ─────────────────────────────────────────────
class _AppColors {
  static const gradientStart = Color(0xFFFF416C);
  static const gradientEnd = Color(0xFFFF4B2B);
  static const overlay = Color(0x99000000); // 60 % black
  static const overlayDeep = Color(0xCC000000); // 80 % black (bottom fade)
  static const white = Colors.white;
  static const white70 = Colors.white70;
  static const white38 = Colors.white38;
}

// ─────────────────────────────────────────────
//  Animation durations
// ─────────────────────────────────────────────
class _Dur {
  static const base = Duration(milliseconds: 600);
  static const logo = Duration(milliseconds: 700);
  static const tagline = Duration(milliseconds: 700);
  static const welcome = Duration(milliseconds: 750);
  static const btn1 = Duration(milliseconds: 650);
  static const btn2 = Duration(milliseconds: 650);
  static const social = Duration(milliseconds: 600);
}

class _Del {
  static const logo = Duration(milliseconds: 0);
  static const tagline = Duration(milliseconds: 150);
  static const welcome = Duration(milliseconds: 300);
  static const btn1 = Duration(milliseconds: 450);
  static const btn2 = Duration(milliseconds: 570);
  static const social = Duration(milliseconds: 680);
}

// ─────────────────────────────────────────────
//  Welcome Screen
// ─────────────────────────────────────────────
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // Each element gets its own controller for precise stagger control
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fades;
  late final List<Animation<Offset>> _slides;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final durations = [
      _Dur.logo,
      _Dur.tagline,
      _Dur.welcome,
      _Dur.btn1,
      _Dur.btn2,
      _Dur.social,
    ];

    final delays = [
      _Del.logo,
      _Del.tagline,
      _Del.welcome,
      _Del.btn1,
      _Del.btn2,
      _Del.social,
    ];

    _controllers = List.generate(
      durations.length,
      (i) => AnimationController(vsync: this, duration: durations[i]),
    );

    _fades = _controllers.map((c) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: c, curve: Curves.easeOut),
      );
    }).toList();

    _slides = _controllers.map((c) {
      return Tween<Offset>(
        begin: const Offset(0, 0.30),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic));
    }).toList();

    // Fire each controller after its delay
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(delays[i], () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // ── Helper: wrap a child in fade + slide
  Widget _animated(int index, Widget child) {
    return FadeTransition(
      opacity: _fades[index],
      child: SlideTransition(position: _slides[index], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSmall = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image ────────────────────────────────────
          Image.asset(
            'assets/images/gym_bg.jpg',
            fit: BoxFit.cover,
          ),

          // ── Gradient overlay (top subtle → bottom dark) ─────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x80000000), // 50 % at top
                  Color(0xCC000000), // 80 % at 60 %
                  Color(0xF2000000), // 95 % at bottom
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────────
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.07,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: isSmall ? 16 : 28),

                            // ── Logo row ──────────────────────
                            _animated(
                              0,
                              _LogoBadge(isSmall: isSmall),
                            ),

                            SizedBox(height: isSmall ? 6 : 10),

                            // ── Tagline ───────────────────────
                            _animated(
                              1,
                              _TaglineChips(),
                            ),

                            const Spacer(),

                            // ── WELCOME headline ──────────────
                            _animated(
                              2,
                              _WelcomeHeadline(isSmall: isSmall),
                            ),

                            SizedBox(height: isSmall ? 28 : 40),

                            // ── Sign In button ────────────────
                            _animated(
                              3,
                              GradientButton(
                                text: 'SIGN IN',
                                onTap: () {},
                                gradientColors: const [
                                  Color(0xFFFF416C),
                                  Color(0xFFFF4B2B),
                                ],
                              ),
                            ),

                            SizedBox(height: isSmall ? 14 : 18),

                            // ── Sign Up button (outlined) ─────
                            _animated(
                              4,
                              GradientButton(
                                text: 'SIGN UP',
                                onTap: () {},
                                isOutlined: true,
                                gradientColors: const [
                                  Color(0xFFFF416C),
                                  Color(0xFFFF4B2B),
                                ],
                              ),
                            ),

                            SizedBox(height: isSmall ? 28 : 40),

                            // ── Social section ────────────────
                            _animated(
                              5,
                              _SocialSection(),
                            ),

                            SizedBox(height: isSmall ? 20 : 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Logo Badge
// ─────────────────────────────────────────────
class _LogoBadge extends StatelessWidget {
  final bool isSmall;
  const _LogoBadge({required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Accent line above brand name
        Container(
          width: 36,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'NIPFITNESS',
          style: GoogleFonts.rajdhani(
            color: Colors.white,
            fontSize: isSmall ? 26 : 32,
            fontWeight: FontWeight.w700,
            letterSpacing: 5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Tagline chips row
// ─────────────────────────────────────────────
class _TaglineChips extends StatelessWidget {
  const _TaglineChips();

  static const _items = ['GYM', 'FITNESS', 'YOGA'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _items.asMap().entries.map((e) {
        final isLast = e.key == _items.length - 1;
        return Row(
          children: [
            Text(
              e.value,
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
              ),
            ),
            if (!isLast)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF416C),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  Welcome Headline
// ─────────────────────────────────────────────
class _WelcomeHeadline extends StatelessWidget {
  final bool isSmall;
  const _WelcomeHeadline({required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'WELCOME',
          style: GoogleFonts.rajdhani(
            color: Colors.white,
            fontSize: isSmall ? 48 : 62,
            fontWeight: FontWeight.w700,
            letterSpacing: 10,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 10),
        // Subtle red underline accent
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Push your limits. Transform your life.',
          style: GoogleFonts.inter(
            color: Colors.white54,
            fontSize: isSmall ? 13 : 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Social Login Section
// ─────────────────────────────────────────────
class _SocialSection extends StatelessWidget {
  const _SocialSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with label
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.white.withOpacity(0.15), height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'or continue with',
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
              child: Divider(color: Colors.white.withOpacity(0.15), height: 1),
            ),
          ],
        ),

        const SizedBox(height: 22),

        // Social buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SocialLoginButton(
              icon: Icons.g_mobiledata,
              label: 'Google',
              iconColor: Colors.white,
            ),
            SizedBox(width: 20),
            SocialLoginButton(
              icon: Icons.facebook,
              label: 'Facebook',
              iconColor: Color(0xFF4267B2),
            ),
            SizedBox(width: 20),
            SocialLoginButton(
              icon: Icons.apple,
              label: 'Apple',
              iconColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}