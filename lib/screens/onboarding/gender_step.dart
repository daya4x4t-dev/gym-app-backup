import 'package:flutter/material.dart';

/// Step 1 — Gender Selection
class GenderStep extends StatefulWidget {
  final VoidCallback onContinue;
  const GenderStep({super.key, required this.onContinue});

  @override
  State<GenderStep> createState() => _GenderStepState();
}

class _GenderStepState extends State<GenderStep> {
  String? _selected; // 'male' | 'female'

  static const _red = Color(0xFFE53935);

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
            'Tell Us About\nYourself',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A2E),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'To give you better exercise and results\nwe need to know your gender.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // ── Cards ──────────────────────────────────────────────────────────
          Row(
            children: [
              // Male
              Expanded(
                child: _GenderCard(
                  label: 'Male',
                  emoji: '🏋️',
                  selected: _selected == 'male',
                  accentColor: _red,
                  onTap: () => setState(() => _selected = 'male'),
                ),
              ),
              const SizedBox(width: 16),
              // Female
              Expanded(
                child: _GenderCard(
                  label: 'Female',
                  emoji: '🧘',
                  selected: _selected == 'female',
                  accentColor: _red,
                  onTap: () => setState(() => _selected = 'female'),
                ),
              ),
            ],
          ),

          const Spacer(),

          // ── Continue Button ────────────────────────────────────────────────
          _ContinueButton(
            enabled: _selected != null,
            onTap: widget.onContinue,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final Color accentColor;
  final VoidCallback onTap;

  const _GenderCard({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          color: selected ? accentColor.withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? accentColor : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 52)),
            const SizedBox(height: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: selected ? accentColor : const Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 12),
            // Radio indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? accentColor : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable continue button used by all steps.
class _ContinueButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;

  const _ContinueButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: enabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          disabledBackgroundColor: Colors.grey.shade300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: enabled ? Colors.white : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
