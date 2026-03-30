import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym/screens/settings_screen.dart';
import 'package:gym/models/stat_model.dart';
import 'package:gym/models/brand_model.dart';
import 'package:gym/utils/app_theme.dart';
import 'package:gym/widgets/stat_card.dart';
import 'package:gym/screens/local_clash_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  // ─────────────────────────────────────────────────────────
  // DATA
  // ─────────────────────────────────────────────────────────
  static const _stats = [
    FitnessStat(
        icon: Icons.favorite_rounded,
        label: 'Heart Rate',
        value: '78 bpm',
        color: Color(0xFFFFF1F1),
        iconColor: Colors.red),
    FitnessStat(
        icon: Icons.local_fire_department_rounded,
        label: 'Calories',
        value: '420 kcal',
        color: Color(0xFFFFF7EF),
        iconColor: Colors.orange),
    FitnessStat(
        icon: Icons.directions_walk_rounded,
        label: 'Steps',
        value: '6,240',
        color: Color(0xFFF1FFF1),
        iconColor: Colors.green),
    FitnessStat(
        icon: Icons.monitor_weight_rounded,
        label: 'Weight',
        value: '72 kg',
        color: Color(0xFFF1F7FF),
        iconColor: Colors.blue),
    FitnessStat(
        icon: Icons.restaurant_menu_rounded,
        label: 'Diet Plan',
        value: 'On Track',
        color: Color(0xFFFFFDE3),
        iconColor: Colors.amber),
  ];

  static const _brands = [
    GymBrand(name: 'Life Fitness', icon: Icons.bolt_rounded),
    GymBrand(name: 'Technogym', icon: Icons.sports_gymnastics_rounded),
    GymBrand(name: 'Rogue', icon: Icons.fitness_center_rounded),
    GymBrand(name: 'Energy Fitness', icon: Icons.electric_bolt_rounded),
    GymBrand(name: 'NordicTrack', icon: Icons.run_circle_rounded),
  ];

  // Enhanced workout list with category & color
  static const _workouts = [
    _WorkoutData(
      title: 'Deadlift',
      tag: 'Dead Lift',
      level: 'Advanced',
      duration: '45 min',
      category: 'Strength',
      gradientStart: Color(0xFF1C1C2E),
      gradientEnd: Color(0xFF2D1B69),
      accentColor: Color(0xFF7C3AED),
    ),
    _WorkoutData(
      title: 'Bench Press',
      tag: 'Chest',
      level: 'Intermediate',
      duration: '30 min',
      category: 'Strength',
      gradientStart: Color(0xFF1A1A2E),
      gradientEnd: Color(0xFF16213E),
      accentColor: Color(0xFF0F3460),
    ),
    _WorkoutData(
      title: 'Squats',
      tag: 'Legs',
      level: 'Intermediate',
      duration: '40 min',
      category: 'Cardio',
      gradientStart: Color(0xFF1B2838),
      gradientEnd: Color(0xFF0F2027),
      accentColor: Color(0xFF00B4D8),
    ),
    _WorkoutData(
      title: 'Pull Ups',
      tag: 'Back',
      level: 'Advanced',
      duration: '20 min',
      category: 'Strength',
      gradientStart: Color(0xFF1F1B24),
      gradientEnd: Color(0xFF2D1515),
      accentColor: Color(0xFFE53935),
    ),
  ];

  static const _categories = ['All', 'Strength', 'Cardio', 'Flexibility', 'HIIT'];

  // ─────────────────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────────────────
  static const int _carouselItemCount = 2;
  late final PageController _carouselController;
  int _currentCarouselPage = 0;
  Timer? _carouselTimer;
  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = PageController(viewportFraction: 0.88);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_currentCarouselPage + 1) % _carouselItemCount;
      _carouselController.animateToPage(
        next,
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
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
  // ROOT BUILD
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
              _buildProgressBanner(),
              _buildFeaturedCarousel(),
              _buildStatsGroup(),
              _buildSectionHeader('Top Gym Brand'),
              _buildBrandList(),
              _buildSectionHeader('Top Workouts'),
              _buildCategoryFilter(),
              _buildWorkoutsGrid(),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // PROGRESS BANNER  (new)
  // ─────────────────────────────────────────────────────────
  Widget _buildProgressBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFB71C1C)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53935).withAlpha(80),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.trending_up_rounded,
                  color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Weekly Goal: 4 / 5 Workouts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.8,
                      minHeight: 6,
                      backgroundColor: Colors.white.withAlpha(50),
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '80%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
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
        Container(
          constraints: const BoxConstraints(minHeight: 188, maxHeight: 220),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: index == 0
                      ? const _FeaturedBannerCard()
                      : const _LocalClashCard(),
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
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppTheme.accentRed.withAlpha(51), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFEEEEEE),
                    child: Icon(Icons.person, color: AppTheme.textGreyLight),
                  ),
                ),
                // Online indicator dot
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
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
          _circleIconBtn(Icons.notifications_none_rounded, badge: true),
        ],
      ),
    );
  }

  Widget _circleIconBtn(IconData icon, {bool badge = false}) => Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(10), blurRadius: 10)
          ],
        ),
        child: Icon(icon, color: AppTheme.textDark, size: 24),
      ),
      if (badge)
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppTheme.accentRed,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
        ),
    ],
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
          Text('Good Morning 💪',
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
                      value: stat.value,
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
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentRed.withAlpha(15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('View All',
                style: TextStyle(
                    color: AppTheme.accentRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w800)),
          ),
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
  // CATEGORY FILTER  (new)
  // ─────────────────────────────────────────────────────────
  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_categories.length, (i) {
          final selected = i == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(right: 10),
              padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color:
                selected ? AppTheme.accentRed : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: selected
                    ? [
                  BoxShadow(
                      color: AppTheme.accentRed.withAlpha(80),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ]
                    : [
                  BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 6)
                ],
              ),
              child: Text(
                _categories[i],
                style: TextStyle(
                  color: selected ? Colors.white : AppTheme.textGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // WORKOUTS GRID  (2 rows × 2 cards)
  // ─────────────────────────────────────────────────────────
  Widget _buildWorkoutsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Row 1
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _WorkoutRefinedCard(workout: _workouts[0])),
                const SizedBox(width: 14),
                Expanded(child: _WorkoutRefinedCard(workout: _workouts[1])),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Row 2
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _WorkoutRefinedCard(workout: _workouts[2])),
                const SizedBox(width: 14),
                Expanded(child: _WorkoutRefinedCard(workout: _workouts[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// WORKOUT DATA MODEL  (internal, enhanced)
// ═══════════════════════════════════════════════════════════
class _WorkoutData {
  final String title;
  final String tag;
  final String level;
  final String duration;
  final String category;
  final Color gradientStart;
  final Color gradientEnd;
  final Color accentColor;

  const _WorkoutData({
    required this.title,
    required this.tag,
    required this.level,
    required this.duration,
    required this.category,
    required this.gradientStart,
    required this.gradientEnd,
    required this.accentColor,
  });
}

// ═══════════════════════════════════════════════════════════
// FEATURED BANNER CARD
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
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 16, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
        BoxShadow(
            color: color.withAlpha(50), blurRadius: 8, spreadRadius: 1)
      ],
    ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 16, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE53935).withAlpha(38),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: const Color(0xFFE53935).withAlpha(100),
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
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LocalClashScreen())),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _glowIcon(
                          Icons.emoji_events_rounded, const Color(0xFFFFD700)),
                      const SizedBox(height: 10),
                      _glowIcon(
                          Icons.leaderboard_rounded, const Color(0xFF64B5F6)),
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
            child: Center(
                child: Icon(brand.icon,
                    color: Colors.grey.shade400, size: 28)),
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
// WORKOUT REFINED CARD  (enhanced with level badge + category chip)
// ═══════════════════════════════════════════════════════════
class _WorkoutRefinedCard extends StatelessWidget {
  final _WorkoutData workout;
  const _WorkoutRefinedCard({required this.workout});

  Color get _levelColor {
    switch (workout.level) {
      case 'Advanced':
        return const Color(0xFFE53935);
      case 'Intermediate':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.hardEdge,
      child: Container(
        constraints: const BoxConstraints(minHeight: 210),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [workout.gradientStart, workout.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
                color: workout.accentColor.withAlpha(60),
                blurRadius: 14,
                offset: const Offset(0, 6))
          ],
        ),
        child: Stack(
          children: [
            // Accent glow circle
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: workout.accentColor.withAlpha(40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top row: tag chip + level badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tag
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
                      // Level badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 4),
                        decoration: BoxDecoration(
                          color: _levelColor.withAlpha(35),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _levelColor.withAlpha(120), width: 1),
                        ),
                        child: Text(
                          workout.level,
                          style: TextStyle(
                            color: _levelColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 65),
                  // Bottom: title + meta + favourite
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
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.timer_outlined,
                              color: Colors.white60, size: 12),
                          const SizedBox(width: 4),
                          Text(workout.duration,
                              style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(width: 10),
                          Icon(Icons.category_outlined,
                              color: Colors.white60, size: 12),
                          const SizedBox(width: 4),
                          Text(workout.category,
                              style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Action row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(20),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withAlpha(40),
                                  width: 1),
                            ),
                            child: const Text('Start',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800)),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white70,
                                size: 16),
                          ),
                        ],
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