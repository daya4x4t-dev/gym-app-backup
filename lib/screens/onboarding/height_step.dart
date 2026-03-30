import 'package:flutter/material.dart';

/// Step 3 — Height Selection (vertical drum roller, cm)
class HeightStep extends StatefulWidget {
  final VoidCallback onContinue;
  const HeightStep({super.key, required this.onContinue});

  @override
  State<HeightStep> createState() => _HeightStepState();
}

class _HeightStepState extends State<HeightStep> {
  static const _minH = 100;
  static const _maxH = 250;
  static const _initialH = 175;
  static const _red = Color(0xFFE53935);

  late final FixedExtentScrollController _ctrl;
  int _selectedH = _initialH;

  @override
  void initState() {
    super.initState();
    _ctrl = FixedExtentScrollController(
      initialItem: _initialH - _minH,
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
          // ── Title ────────────────────────────────────────────────────────
          const Text(
            'What is Your\nHeight?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: _red,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Height in cm. Don\'t worry, you can always change it later.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          // ── Picker ────────────────────────────────────────────────────────
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Highlight band
                Center(
                  child: Container(
                    height: 56,
                    margin: const EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      color: _red.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _red.withValues(alpha: 0.2)),
                    ),
                  ),
                ),
                ListWheelScrollView.useDelegate(
                  controller: _ctrl,
                  itemExtent: 56,
                  perspective: 0.003,
                  diameterRatio: 2.5,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (i) =>
                      setState(() => _selectedH = i + _minH),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: _maxH - _minH + 1,
                    builder: (context, index) {
                      final h = index + _minH;
                      final isSelected = h == _selectedH;
                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$h',
                              style: TextStyle(
                                fontSize: isSelected ? 36 : 22,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w400,
                                color:
                                    isSelected ? _red : Colors.grey.shade400,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  'cm',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _red.withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Continue ───────────────────────────────────────────────────────
          _ContinueButton(onTap: widget.onContinue),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
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
          'Continue',
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
