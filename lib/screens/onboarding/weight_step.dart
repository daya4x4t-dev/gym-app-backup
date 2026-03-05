import 'package:flutter/material.dart';

/// Step 4 — Weight Selection (horizontal drum roller with triangle pointer)
class WeightStep extends StatefulWidget {
  final VoidCallback onContinue;
  const WeightStep({super.key, required this.onContinue});

  @override
  State<WeightStep> createState() => _WeightStepState();
}

class _WeightStepState extends State<WeightStep> {
  static const _minW = 30;
  static const _maxW = 200;
  static const _initialW = 70;
  static const _red = Color(0xFFE53935);

  late final FixedExtentScrollController _ctrl;
  int _selectedW = _initialW;

  @override
  void initState() {
    super.initState();
    _ctrl = FixedExtentScrollController(
      initialItem: _initialW - _minW,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // ── Title ─────────────────────────────────────────────────────────
          const Text(
            'What is Your\nWeight?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: _red,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Weight in kg. Don\'t worry, you can always change it later.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),

          const Spacer(),

          // ── Horizontal Picker ──────────────────────────────────────────────
          SizedBox(
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Numbers row using RotatedBox trick
                SizedBox(
                  height: 70,
                  child: RotatedBox(
                    quarterTurns: -1, // make it horizontal
                    child: ListWheelScrollView.useDelegate(
                      controller: _ctrl,
                      itemExtent: 56,
                      perspective: 0.003,
                      diameterRatio: 3.0,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (i) =>
                          setState(() => _selectedW = i + _minW),
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _maxW - _minW + 1,
                        builder: (context, index) {
                          final w = index + _minW;
                          final isSelected = w == _selectedW;
                          return RotatedBox(
                            quarterTurns: 1, // rotate text back upright
                            child: Center(
                              child: Text(
                                '$w',
                                style: TextStyle(
                                  fontSize: isSelected ? 28 : 18,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? _red
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // ── Triangle pointer indicator ─────────────────────────────
                CustomPaint(
                  size: const Size(20, 12),
                  painter: _TrianglePainter(color: _red),
                ),
              ],
            ),
          ),

          // ── kg label ──────────────────────────────────────────────────────
          Center(
            child: Text(
              '$_selectedW kg',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _red,
              ),
            ),
          ),

          const Spacer(),

          // ── Continue ───────────────────────────────────────────────────────
          _ContinueButton(onTap: widget.onContinue),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Triangle pointer (▼) painted below the center number
class _TrianglePainter extends CustomPainter {
  final Color color;
  const _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ContinueButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Complete Setup',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
