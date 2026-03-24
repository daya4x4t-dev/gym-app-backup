import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:gym/utils/app_theme.dart';
import 'package:gym/widgets/stat_card.dart';

class ActivityProgressScreen extends StatefulWidget {
  const ActivityProgressScreen({super.key});

  @override
  State<ActivityProgressScreen> createState() => _ActivityProgressScreenState();
}

class _ActivityProgressScreenState extends State<ActivityProgressScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _mainController, curve: Curves.easeOut);
    _slideAnim = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
    );

    // Subtle pulse for the water-add button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _mainController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _mainController,
          builder: (context, _) {
            return Opacity(
              opacity: _fadeAnim.value,
              child: Transform.translate(
                offset: Offset(0, _slideAnim.value),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildLocalClashBox(),
                      const SizedBox(height: 20),
                      _buildTopStats(),
                      const SizedBox(height: 20),
                      _buildChartCard(),
                      const SizedBox(height: 20),
                      _buildNutritionAndWater(),
                      const SizedBox(height: 28),
                      _buildDailyGoal(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── 1. Header ──────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Activity Progress',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.calendar_month_outlined,
                    color: AppTheme.textGreyLight, size: 14),
                SizedBox(width: 5),
                Text(
                  'Monday, 12 Jan 2026',
                  style: TextStyle(
                    color: AppTheme.textGreyLight,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Profile avatar with notification dot
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: const Icon(Icons.person_outline_rounded,
                  color: AppTheme.textGreyLight, size: 22),
            ),
            Positioned(
              right: 3,
              top: 3,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── 2. Local Clash Box ─────────────────────────────────────────────────────
  Widget _buildLocalClashBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.textDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            AppTheme.textDark,
            const Color(0xFF2C2C3E), // Slightly lighter dark tone
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.orangeCalories.withAlpha(40),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.flash_on_rounded,
              color: AppTheme.orangeCalories,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Join Local Clash',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Compete with 12 nearby users!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // CTA Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.orangeCalories,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Join',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── 3. Top Stats (Calories & Steps) ────────────────────────────────────────
  Widget _buildTopStats() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Icons.local_fire_department_rounded,
            iconColor: AppTheme.orangeCalories,
            iconBgColor: AppTheme.orangeCalories.withAlpha(25),
            title: 'CALORIES',
            value: '1,240',
            unit: 'kcal',
            trend: '+8%',
            isPositive: true,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: StatCard(
            icon: Icons.directions_walk_rounded,
            iconColor: AppTheme.greenAccent,
            iconBgColor: AppTheme.greenAccent.withAlpha(25),
            title: 'STEPS',
            value: '8,432',
            unit: 'steps',
            trend: '+12%',
            isPositive: true,
          ),
        ),
      ],
    );
  }

  // ── 3. Weekly Line Chart ───────────────────────────────────────────────────
  Widget _buildChartCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calories Burnt',
                style: TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.greenAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+12% vs last week',
                  style: TextStyle(
                    color: AppTheme.greenAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(_mainController.value),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ChartLabel('Tue'),
              _ChartLabel('Wed'),
              _ChartLabel('Thu'),
              _ChartLabel('Fri'),
              _ChartLabel('Sat'),
              _ChartLabel('Sun'),
            ],
          ),
        ],
      ),
    );
  }

  // ── 4. Nutrition + Water Intake ────────────────────────────────────────────
  Widget _buildNutritionAndWater() {
    return Row(
      children: [
        // Nutrition donut card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: 240,
            decoration: _cardDecoration(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nutrition',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter:
                          _DonutChartPainter(_mainController.value),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _LegendDot(color: AppTheme.purplePrimary, label: 'Protein'),
                    SizedBox(width: 12),
                    _LegendDot(color: AppTheme.tealCarbs, label: 'Carbs'),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _LegendDot(color: AppTheme.orangeCalories, label: 'Fats'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Water intake card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: 240,
            decoration: _cardDecoration(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Water Intake',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: '1.8 ',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: '/ 2.5 L',
                      style: TextStyle(
                        color: AppTheme.textGreyLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 8),
                // Water level pill
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 38,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // Background pill
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          // Filled water level (animated)
                          FractionallySizedBox(
                            heightFactor:
                                0.72 * _mainController.value,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.blueWater.withAlpha(153),
                                    AppTheme.blueWater,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          // Shine overlay
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withAlpha(64),
                                  Colors.transparent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // ADD 250ML button with subtle pulse
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale =
                        1.0 + (_pulseController.value * 0.03);
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: AppTheme.blueWater.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'ADD 250ML',
                      style: TextStyle(
                        color: AppTheme.blueWater,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── 5. Daily Goal ──────────────────────────────────────────────────────────
  Widget _buildDailyGoal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Daily Goal',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              'View Detail',
              style: TextStyle(
                color: AppTheme.purplePrimary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: _cardDecoration(28),
          child: Column(
            children: [
              _GoalBar(
                icon: Icons.timer_outlined,
                label: 'Workout',
                pct: 80,
                color: AppTheme.purplePrimary,
                progress: _mainController,
              ),
              const SizedBox(height: 22),
              _GoalBar(
                icon: Icons.water_drop_outlined,
                label: 'Water Intake',
                pct: 72,
                color: AppTheme.blueWater,
                progress: _mainController,
              ),
              const SizedBox(height: 22),
              _GoalBar(
                icon: Icons.bedtime_outlined,
                label: 'Sleep',
                pct: 65,
                color: Colors.deepPurpleAccent,
                progress: _mainController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Shared card decoration ─────────────────────────────────────────────────
  BoxDecoration _cardDecoration(double radius) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(10),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  REUSABLE WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

// ── Daily Goal Progress Bar ──────────────────────────────────────────────────
class _GoalBar extends StatelessWidget {
  final IconData icon;
  final String label;
  final int pct;
  final Color color;
  final AnimationController progress;

  const _GoalBar({
    required this.icon,
    required this.label,
    required this.pct,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '$pct%',
              style: const TextStyle(
                color: AppTheme.textGrey,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: progress,
          builder: (context, _) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (pct / 100) * progress.value,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withAlpha(179),
                          color,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ── Chart Day Label ──────────────────────────────────────────────────────────
class _ChartLabel extends StatelessWidget {
  final String text;
  const _ChartLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppTheme.textGrey,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// ── Legend Dot ────────────────────────────────────────────────────────────────
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textGrey,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  CUSTOM PAINTERS
// ═══════════════════════════════════════════════════════════════════════════════

// ── Line Chart ───────────────────────────────────────────────────────────────
class _LineChartPainter extends CustomPainter {
  final double progress;
  _LineChartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final w = size.width;
    final h = size.height;

    // Data points (Tue → Sun)
    final pts = [
      Offset(0, h * 0.70),
      Offset(w * 0.20, h * 0.30),
      Offset(w * 0.40, h * 0.50),
      Offset(w * 0.60, h * 0.35),
      Offset(w * 0.80, h * 0.60),
      Offset(w * 0.90, h * 0.10),
      Offset(w, h * 0.85),
    ];

    // Build smooth Bézier spline
    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (var i = 0; i < pts.length - 1; i++) {
      final cp1 = Offset(pts[i].dx + (pts[i + 1].dx - pts[i].dx) / 2, pts[i].dy);
      final cp2 = Offset(pts[i].dx + (pts[i + 1].dx - pts[i].dx) / 2, pts[i + 1].dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i + 1].dx, pts[i + 1].dy);
    }

    // Gradient fill under the curve
    final fillPath = Path.from(path)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF7B61FF).withAlpha((46 * progress).toInt()),
          const Color(0xFF7B61FF).withAlpha(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Animated line stroke
    final linePaint = Paint()
      ..color = const Color(0xFF7B61FF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final metric in path.computeMetrics()) {
      canvas.drawPath(
        metric.extractPath(0, metric.length * progress),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => old.progress != progress;
}

// ── Donut Chart ──────────────────────────────────────────────────────────────
class _DonutChartPainter extends CustomPainter {
  final double progress;
  _DonutChartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const stroke = 14.0;
    const gap = 0.12;

    // Protein (purple)  – 48 %
    _arc(canvas, center, radius, stroke, -math.pi / 2,
        math.pi * 0.96 * progress, const Color(0xFF7B61FF));

    // Carbs (teal)      – 35 %
    _arc(canvas, center, radius, stroke, math.pi * 0.48 + gap,
        math.pi * 0.70 * progress, AppTheme.tealCarbs);

    // Fats (orange)     – 17 %
    _arc(canvas, center, radius, stroke, math.pi * 1.20 + gap,
        math.pi * 0.30 * progress, AppTheme.orangeCalories);
  }

  void _arc(Canvas canvas, Offset center, double r, double sw,
      double start, double sweep, Color color) {
    if (sweep <= 0) return;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: r - sw / 2),
      start,
      sweep,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = sw
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter old) => old.progress != progress;
}
