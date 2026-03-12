import 'package:gym/screens/settings_screen.dart';
import 'package:flutter/material.dart';

// ─── Design Tokens ───────────────────────────────────────────────────────────
const _accentRed     = Color(0xFFE53935);
const _accentRedDark = Color(0xFFC62828);
const _bgLight       = Color(0xFFF5F6FA);
const _textDark      = Color(0xFF1C1C2E);
const _textGrey      = Color(0xFF8A8FA3);
const _cardWhite     = Colors.white;

// ─────────────────────────────────────────────────────────────────────────────

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      extendBody: true,
      // ── AI Trainer FAB ─────────────────────────────────────────────────────
      floatingActionButton: _buildAITrainerFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ── Bottom Nav ─────────────────────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildGreeting(),
              _buildSearchBar(),
              _buildFeaturedBanner(),
              _buildStatsGroup(),
              _buildSectionHeader('Top Gym Brand'),
              _buildBrandList(),
              _buildSectionHeader('Top Workout'),
              _buildWorkoutsGrid(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  // ── AI Trainer Floating Button ────────────────────────────────────────────
  Widget _buildAITrainerFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_accentRed, _accentRedDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: _accentRed.withValues(alpha: 0.55),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.auto_fix_high_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'AI Trainer',
          style: TextStyle(
            color: _accentRed,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  // ── 1. Header ──────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _accentRed.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(color: _accentRed, width: 2.5),
            ),
            child: const CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFEEEEEE),
              child: Icon(Icons.person_rounded, color: _textGrey, size: 28),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'B.Dayanithi',
                  style: TextStyle(
                    color: _textDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, color: _accentRed, size: 13),
                    const SizedBox(width: 3),
                    const Text(
                      'Dubai, UAE',
                      style: TextStyle(
                        color: _textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildCircleIconButton(Icons.notifications_none_rounded),
        ],
      ),
    );
  }

  // ── 2. Greeting ────────────────────────────────────────────────────────────
  Widget _buildGreeting() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 22, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning 👋',
            style: TextStyle(
              color: _textDark,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Ready for today\'s workout?',
            style: TextStyle(
              color: _textGrey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  // ── 3. Search Bar ──────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: _cardWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search_rounded, color: _textGrey, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search workouts, gyms or equip...',
                      style: TextStyle(
                        color: _textGrey,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_accentRed, _accentRedDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _accentRed.withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  // ── 4. Featured Banner ─────────────────────────────────────────────────────
  Widget _buildFeaturedBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        width: double.infinity,
        // No fixed height — card sizes itself to content
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1C2E), Color(0xFF2D1B1B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Decorative blobs — must not affect layout, so use Positioned.fill base
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _accentRed.withValues(alpha: 0.18),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        bottom: -20,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _accentRed.withValues(alpha: 0.10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content — drives the card height
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _accentRed.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _accentRed.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'FEATURED PROGRAM',
                        style: TextStyle(
                          color: _accentRed,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Top Workouts\nof 2025',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: _accentRed.withValues(alpha: 0.5),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentRed,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                        ),
                        child: const Text(
                          'Start Workout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── 5. Stats Group ─────────────────────────────────────────────────────────
  Widget _buildStatsGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        decoration: BoxDecoration(
          color: _cardWhite,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: const Row(
                children: [
                  _StatSmallCard(
                    icon: Icons.favorite_rounded,
                    label: 'Heart Rate',
                    bgColor: Color(0xFFFFF0F0),
                    iconColor: Color(0xFFE53935),
                  ),
                  SizedBox(width: 16),
                  _StatSmallCard(
                    icon: Icons.local_fire_department_rounded,
                    label: 'Calories',
                    bgColor: Color(0xFFFFF4EC),
                    iconColor: Color(0xFFFF6D00),
                  ),
                  SizedBox(width: 16),
                  _StatSmallCard(
                    icon: Icons.directions_walk_rounded,
                    label: 'Steps',
                    bgColor: Color(0xFFEDF9F0),
                    iconColor: Color(0xFF2E7D32),
                  ),
                  SizedBox(width: 16),
                  _StatSmallCard(
                    icon: Icons.monitor_weight_rounded,
                    label: 'Weight',
                    bgColor: Color(0xFFEEF3FF),
                    iconColor: Color(0xFF3949AB),
                  ),
                  SizedBox(width: 16),
                  _StatSmallCard(
                    icon: Icons.restaurant_menu_rounded,
                    label: 'Diet Plan',
                    bgColor: Color(0xFFFFFDE8),
                    iconColor: Color(0xFFFFA000),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center_rounded, color: _accentRed, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'View Gym Equipment',
                        style: TextStyle(
                          color: _accentRed,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Header ─────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _accentRed.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'View All',
              style: TextStyle(
                color: _accentRed,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Brand List ─────────────────────────────────────────────────────────────
  Widget _buildBrandList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: const Row(
        children: [
          _BrandItem(name: 'Life Fitness', icon: Icons.bolt_rounded),
          _BrandItem(name: 'Technogym', icon: Icons.sports_gymnastics_rounded),
          _BrandItem(name: 'Rogue', icon: Icons.fitness_center_rounded),
          _BrandItem(name: 'Energy Fitness', icon: Icons.electric_bolt_rounded),
          _BrandItem(name: 'NordicTrack', icon: Icons.run_circle_rounded),
        ],
      ),
    );
  }

  // ── Workouts Grid ──────────────────────────────────────────────────────────
  Widget _buildWorkoutsGrid() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _WorkoutRefinedCard(
              title: 'Deadlift',
              tag: 'Dead Lift',
              level: 'Advanced',
              duration: '45 min',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _WorkoutRefinedCard(
              title: 'Bench Press',
              tag: 'Bench Press',
              level: 'Intermediate',
              duration: '30 min',
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav ─────────────────────────────────────────────────────────────
  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      color: Colors.white.withValues(alpha: 0.98),
      elevation: 0,
      notchMargin: 10,
      clipBehavior: Clip.antiAlias,
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Left side items
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_rounded, 'Home', isActive: true),
                  _buildNavItem(Icons.explore_outlined, 'Explore'),
                ],
              ),
            ),
            // Centered gap for the FAB notch
            const SizedBox(width: 80),
            // Right side items
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.analytics_outlined, 'Stats'),
                  _buildNavItem(
                    Icons.person_outline_rounded,
                    'Profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label,
      {bool isActive = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: const BoxDecoration(
                color: _accentRed,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(height: 8),
          Icon(
            icon,
            color: isActive ? _accentRed : Colors.grey,
            size: 26,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: isActive ? _accentRed : _textGrey,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildCircleIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: _cardWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: _textDark, size: 22),
    );
  }
}

// ─── Stat Small Card ─────────────────────────────────────────────────────────

class _StatSmallCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const _StatSmallCard({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: iconColor.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 26),
        ),
        const SizedBox(height: 9),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _textGrey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

// ─── Brand Item ───────────────────────────────────────────────────────────────

class _BrandItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const _BrandItem({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, color: Colors.grey, size: 28),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Workout Refined Card ─────────────────────────────────────────────────────

class _WorkoutRefinedCard extends StatelessWidget {
  final String title;
  final String tag;
  final String level;
  final String duration;

  const _WorkoutRefinedCard({
    required this.title,
    required this.tag,
    required this.level,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C2E), Color(0xFF2A1A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Subtle red glow
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accentRed.withValues(alpha: 0.12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tag badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _accentRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded,
                            color: Colors.white, size: 11),
                        const SizedBox(width: 3),
                        Text(
                          tag.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$level • $duration',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
