import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym/screens/settings_screen.dart';
import 'package:gym/models/workout_model.dart';
import 'package:gym/models/stat_model.dart';
import 'package:gym/models/brand_model.dart';
import 'package:gym/utils/app_theme.dart';
import 'package:gym/widgets/stat_card.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  static const _stats = [
    FitnessStat(icon: Icons.favorite_rounded,           label: 'Heart Rate', color: Color(0xFFFFF1F1), iconColor: Colors.red),
    FitnessStat(icon: Icons.local_fire_department_rounded, label: 'Calories',  color: Color(0xFFFFF7EF), iconColor: Colors.orange),
    FitnessStat(icon: Icons.directions_walk_rounded,    label: 'Steps',      color: Color(0xFFF1FFF1), iconColor: Colors.green),
    FitnessStat(icon: Icons.monitor_weight_rounded,     label: 'Weight',     color: Color(0xFFF1F7FF), iconColor: Colors.blue),
    FitnessStat(icon: Icons.restaurant_menu_rounded,    label: 'Diet Plan',  color: Color(0xFFFFFDE3), iconColor: Colors.amber),
  ];

  static const _brands = [
    GymBrand(name: 'Life Fitness',   icon: Icons.bolt_rounded),
    GymBrand(name: 'Technogym',      icon: Icons.sports_gymnastics_rounded),
    GymBrand(name: 'Rogue',          icon: Icons.fitness_center_rounded),
    GymBrand(name: 'Energy Fitness', icon: Icons.electric_bolt_rounded),
    GymBrand(name: 'NordicTrack',    icon: Icons.run_circle_rounded),
  ];

  static const _workouts = [
    Workout(title: 'Deadlift',    tag: 'Dead Lift',   level: 'Advanced',     duration: '45 min'),
    Workout(title: 'Bench Press', tag: 'Bench Press', level: 'Intermediate', duration: '30 min'),
  ];

  // Carousel
  static const int _carouselItemCount = 2;
  late final PageController _carouselController;
  int _currentCarouselPage = 0;
  Timer? _carouselTimer;

  @override
  void initState() {
    super.initState();
    // viewportFraction < 1 creates the "peek at next card" look.
    _carouselController = PageController(viewportFraction: 0.88);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_currentCarouselPage + 1) % _carouselItemCount;
      _carouselController.animateToPage(
        next,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────
  // Root build
  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildGreeting(),
              _buildSearchBar(),
              _buildFeaturedCarousel(),
              _buildStatsGroup(),
              _buildSectionHeader('Top Gym Brand'),
              _buildBrandList(),
              _buildSectionHeader('Top Workout'),
              _buildWorkoutsGrid(),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // CAROUSEL
  // ─────────────────────────────────────────────────────────
  Widget _buildFeaturedCarousel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Height is fixed so the PageView has a measured constraint.
        // 185 is enough for both cards without overflow.
        SizedBox(
          height: 188,
          child: PageView.builder(
            controller: _carouselController,
            itemCount: _carouselItemCount,
            onPageChanged: (i) => setState(() => _currentCarouselPage = i),
            itemBuilder: (context, index) {
              final isActive = index == _currentCarouselPage;
              return AnimatedScale(
                scale: isActive ? 1.0 : 0.94,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                child: Padding(
                  // Horizontal margin between cards
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: index == 0
                      ? _FeaturedBannerCard()
                      : _LocalClashCard(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        _buildCarouselDots(),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildCarouselDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_carouselItemCount, (i) {
        final active = i == _currentCarouselPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? AppTheme.accentRed : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  // ─────────────────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context, AppTheme.fadeSlideRoute(const SettingsScreen())),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppTheme.accentRed.withAlpha(51), width: 2),
              ),
              child: const CircleAvatar(
                radius: 26,
                backgroundColor: Color(0xFFEEEEEE),
                child: Icon(Icons.person, color: AppTheme.textGreyLight),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('B.Dayanithi',
                    style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900)),
                Row(children: [
                  Icon(Icons.location_on,
                      color: AppTheme.accentRed, size: 14),
                  SizedBox(width: 2),
                  Text('Dubai, UAE',
                      style: TextStyle(
                          color: AppTheme.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ]),
              ],
            ),
          ),
          _circleIconBtn(Icons.notifications_none_rounded),
        ],
      ),
    );
  }

  Widget _circleIconBtn(IconData icon) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10)],
        ),
        child: Icon(icon, color: AppTheme.textDark, size: 24),
      );

  // ─────────────────────────────────────────────────────────
  // GREETING
  // ─────────────────────────────────────────────────────────
  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Good Morning',
              style: TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5)),
          SizedBox(height: 4),
          Text("Ready for today's workout?",
              style: TextStyle(
                  color: AppTheme.textGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // SEARCH BAR
  // ─────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.search_rounded,
                      color: AppTheme.textGrey, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search workouts, gyms or equipment',
                      style: TextStyle(
                          color: AppTheme.textGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppTheme.accentRed,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: AppTheme.accentRed.withAlpha(100),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ],
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // STATS GROUP
  // ─────────────────────────────────────────────────────────
  Widget _buildStatsGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 20,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  for (var stat in _stats) ...[
                    StatCard.small(
                      icon: stat.icon,
                      iconColor: stat.iconColor,
                      iconBgColor: stat.color,
                      title: stat.label,
                      value: '',
                    ),
                    if (stat != _stats.last) const SizedBox(width: 14),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.fitness_center_rounded,
                    color: AppTheme.accentRed, size: 20),
                label: const Text('View Gym Equipment',
                    style: TextStyle(
                        color: AppTheme.accentRed,
                        fontSize: 15,
                        fontWeight: FontWeight.w900)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF5F5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // SECTION HEADER
  // ─────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppTheme.textDark,
                  fontSize: 19,
                  fontWeight: FontWeight.w900)),
          const Text('View All',
              style: TextStyle(
                  color: AppTheme.accentRed,
                  fontSize: 13,
                  fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // BRAND LIST
  // ─────────────────────────────────────────────────────────
  Widget _buildBrandList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child:
          Row(children: _brands.map((b) => _BrandItem(brand: b)).toList()),
    );
  }

  // ─────────────────────────────────────────────────────────
  // WORKOUTS GRID
  // ─────────────────────────────────────────────────────────
  Widget _buildWorkoutsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _WorkoutRefinedCard(workout: _workouts[0])),
          const SizedBox(width: 14),
          Expanded(child: _WorkoutRefinedCard(workout: _workouts[1])),
        ],
      ),
    );
  }

}

// ═══════════════════════════════════════════════════════════
// FEATURED BANNER CARD  (extracted widget — avoids long build method)
// ═══════════════════════════════════════════════════════════
class _FeaturedBannerCard extends StatelessWidget {
  const _FeaturedBannerCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Decorative red circle accent
            Positioned(
              right: -30,
              bottom: -30,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentRed.withAlpha(30),
                ),
              ),
            ),
            // Shadow of red circle
            Positioned(
              right: 20,
              top: 10,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentRed.withAlpha(15),
                ),
              ),
            ),
            // Foreground content
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 16, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text side
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.accentRed.withAlpha(35),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppTheme.accentRed.withAlpha(100),
                                width: 1),
                          ),
                          child: const Text('⚡  FEATURED PROGRAM',
                              style: TextStyle(
                                  color: Color(0xFFFF6B6B),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.8)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Top Workouts\nof 2025',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentRed,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Start Workout',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Icons side
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _glowIcon(
                          Icons.emoji_events_rounded, const Color(0xFFFFD700)),
                      const SizedBox(height: 10),
                      _glowIcon(Icons.timer_rounded, Colors.tealAccent),
                      const SizedBox(height: 10),
                      _glowIcon(
                          Icons.fitness_center_rounded, Colors.white70),
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

  Widget _glowIcon(IconData icon, Color color) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(20),
          border: Border.all(color: color.withAlpha(60), width: 1),
          boxShadow: [
            BoxShadow(color: color.withAlpha(50), blurRadius: 8, spreadRadius: 1)
          ],
        ),
        child: Icon(icon, color: color, size: 19),
      );
}

// ═══════════════════════════════════════════════════════════
// LOCAL CLASH CARD
// ═══════════════════════════════════════════════════════════
class _LocalClashCard extends StatelessWidget {
  const _LocalClashCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D0D), Color(0xFF1B0606), Color(0xFF2D0505)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
              color: const Color(0xFFE53935).withAlpha(70), width: 1.2),
        ),
        child: Stack(
          children: [
            // Glow circles (inside clip so no overflow)
            Positioned(
              right: -24,
              top: -24,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE53935).withAlpha(22),
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: -16,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE53935).withAlpha(14),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 16, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: text + button
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE53935).withAlpha(38),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color:
                                    const Color(0xFFE53935).withAlpha(100),
                                width: 1),
                          ),
                          child: const Text('🎮  MULTIPLAYER',
                              style: TextStyle(
                                  color: Color(0xFFFF6B6B),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.9)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Local Clash',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            shadows: [
                              Shadow(
                                  color: Color(0xFFE53935), blurRadius: 14)
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Compete with nearby players',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Play Now button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor:
                                const Color(0xFFE53935).withAlpha(120),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.sports_esports_rounded,
                                  size: 14, color: Colors.white),
                              SizedBox(width: 6),
                              Text('Play Now',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.3)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Right: gaming glow icons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _glowIcon(Icons.emoji_events_rounded,
                          const Color(0xFFFFD700)),
                      const SizedBox(height: 10),
                      _glowIcon(Icons.leaderboard_rounded,
                          const Color(0xFF64B5F6)),
                      const SizedBox(height: 10),
                      _glowIcon(
                          Icons.group_rounded, const Color(0xFFE53935)),
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

  Widget _glowIcon(IconData icon, Color color) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(20),
          border: Border.all(color: color.withAlpha(65), width: 1),
          boxShadow: [
            BoxShadow(
                color: color.withAlpha(55), blurRadius: 8, spreadRadius: 1)
          ],
        ),
        child: Icon(icon, color: color, size: 19),
      );
}

// ═══════════════════════════════════════════════════════════
// BRAND ITEM
// ═══════════════════════════════════════════════════════════
class _BrandItem extends StatelessWidget {
  final GymBrand brand;
  const _BrandItem({required this.brand});

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
                    color: Colors.black.withAlpha(10), blurRadius: 10)
              ],
              border: Border.all(color: Colors.grey.shade50),
            ),
            child:
                Center(child: Icon(brand.icon, color: Colors.grey.shade400, size: 28)),
          ),
          const SizedBox(height: 10),
          Text(brand.name,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// WORKOUT REFINED CARD
// ═══════════════════════════════════════════════════════════
class _WorkoutRefinedCard extends StatelessWidget {
  final Workout workout;
  const _WorkoutRefinedCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          color: AppTheme.textDark.withAlpha(230),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(28),
                blurRadius: 14,
                offset: const Offset(0, 6))
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withAlpha(210), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tag chip
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.accentRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded,
                        color: Colors.white, size: 11),
                    const SizedBox(width: 3),
                    Text(workout.tag.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5)),
                  ],
                ),
              ),
              // Title + meta
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(workout.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Text('${workout.level} • ${workout.duration}',
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
