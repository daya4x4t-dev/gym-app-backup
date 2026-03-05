import 'package:flutter/material.dart';

/// Step 2 — Age Selection (vertical drum roller)
class AgeStep extends StatefulWidget {
  final VoidCallback onContinue;
  const AgeStep({super.key, required this.onContinue});

  @override
  State<AgeStep> createState() => _AgeStepState();
}

class _AgeStepState extends State<AgeStep> {
  static const _minAge = 10;
  static const _maxAge = 80;
  static const _initialAge = 22;
  static const _red = Color(0xFFE53935);

  late final FixedExtentScrollController _ctrl;
  int _selectedAge = _initialAge;

  @override
  void initState() {
    super.initState();
    _ctrl = FixedExtentScrollController(
      initialItem: _initialAge - _minAge,
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
          Text(
            'How Old Are You?',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: _red,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Age helps us personalize your workout program.',
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
                // Selection highlight band
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
                      setState(() => _selectedAge = i + _minAge),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: _maxAge - _minAge + 1,
                    builder: (context, index) {
                      final age = index + _minAge;
                      final isSelected = age == _selectedAge;
                      return Center(
                        child: Text(
                          '$age',
                          style: TextStyle(
                            fontSize: isSelected ? 36 : 22,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w400,
                            color: isSelected ? _red : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Continue ───────────────────────────────────────────────────────
          _ContinueButton(onTap: onContinue),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void onContinue() => widget.onContinue();
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
