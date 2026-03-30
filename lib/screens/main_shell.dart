import 'package:flutter/material.dart';
import 'package:gym/screens/activity_progress_screen.dart';
import 'package:gym/screens/discover_screen.dart';
import 'package:gym/screens/home_dashboard.dart';
import 'package:gym/screens/settings_screen.dart';
import 'package:gym/utils/app_theme.dart';

/// Root shell that owns the bottom navigation bar.
///
/// Uses [IndexedStack] so every tab stays alive (preserving scroll /
/// animation state) and we never push duplicates.
class MainShell extends StatefulWidget {
  /// Optionally open on a specific tab at launch.
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  // All tab screens — instantiated once, kept alive by IndexedStack.
  static const _screens = <Widget>[
    HomeDashboard(),           // 0 – Home
    DiscoverScreen(),          // 1 – Explore
    ActivityProgressScreen(),  // 2 – Stats
    SettingsScreen(),          // 3 – Profile
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
      value: 1.0, // start fully visible
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return; // already here — do nothing
    _fadeCtrl.reverse().then((_) {
      if (!mounted) return;
      setState(() => _currentIndex = index);
      _fadeCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLightGrey,
      extendBody: true,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─── Bottom Navigation Bar ───────────────────────────────────────────────
  Widget _buildBottomNav() {
    return Container(
      height: 76,  // Increased from 68 for better spacing and touch area
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 24,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ── Nav items row ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_filled, 'Home'),
                _navItem(1, Icons.explore_outlined, 'Discover'),
                const SizedBox(width: 56), // gap for center FAB
                _navItem(2, Icons.analytics_outlined, 'Stats'),
                _navItem(3, Icons.person_outline_rounded, 'Profile'),
              ],
            ),
          ),

          // ── Floating AI Trainer FAB ──────────────────────────────────────
          Positioned(
            top: -10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {}, // AI Trainer action
                  child: Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: AppTheme.accentRed,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentRed.withAlpha(110),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_fix_high_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'AI Trainer',
                  style: TextStyle(
                    color: AppTheme.textGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Increased vertical padding for larger touch target
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                key: ValueKey(active),
                color: active ? AppTheme.accentRed : Colors.grey.shade400,
                size: 23,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: active ? AppTheme.accentRed : AppTheme.textGrey,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
