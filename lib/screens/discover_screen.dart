import 'package:flutter/material.dart';
import 'package:gym/utils/app_theme.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedLevel = 0; // 0=All, 1=Beginner, 2=Intermediate
  static const _levels = ['All', 'Beginner', 'Intermediate'];

  // ── Popular workouts ─────────────────────────────────────────────────────
  static const _popularWorkouts = [
    _WorkoutItem(
      title: 'Heavy Deadlift Mastery',
      duration: '45 mins',
      level: 'Advanced',
      icon: Icons.fitness_center_rounded,
      iconColor: Color(0xFFE53935),
    ),
    _WorkoutItem(
      title: 'Classic Chest Press',
      duration: '30 mins',
      level: 'Intermediate',
      icon: Icons.sports_gymnastics_rounded,
      iconColor: Colors.orange,
    ),
  ];

  // ── Level workouts ───────────────────────────────────────────────────────
  static const _levelWorkouts = [
    _WorkoutItem(
      title: 'Full Body Machine Circuit',
      duration: '40 mins',
      level: 'Beginner',
      icon: Icons.directions_run_rounded,
      iconColor: Colors.teal,
    ),
    _WorkoutItem(
      title: 'Upper Body Power Sculpt',
      duration: '50 mins',
      level: 'Intermediate',
      icon: Icons.airline_seat_legroom_extra_rounded,
      iconColor: Colors.deepPurple,
    ),
    _WorkoutItem(
      title: 'Advanced HIIT Burner',
      duration: '35 mins',
      level: 'Advanced',
      icon: Icons.local_fire_department_rounded,
      iconColor: Color(0xFFE53935),
    ),
  ];

  // ── Body Focus ───────────────────────────────────────────────────────────
  static const _bodyFocus = [
    _BodyFocusItem('Shoulders', Icons.accessibility_new_rounded, Color(0xFF1565C0)),
    _BodyFocusItem('Chest', Icons.person_rounded, Color(0xFF2E7D32)),
    _BodyFocusItem('Arms', Icons.sports_martial_arts_rounded, Color(0xFFE65100)),
    _BodyFocusItem('Back', Icons.airline_seat_recline_extra_rounded, Color(0xFF6A1B9A)),
    _BodyFocusItem('Stomach', Icons.monitor_weight_rounded, Color(0xFF00695C)),
    _BodyFocusItem('Legs', Icons.directions_run_rounded, Color(0xFF558B2F)),
  ];

  // ── Strength workouts ────────────────────────────────────────────────────
  static const _strengthWorkouts = [
    _WorkoutItem(
      title: 'Strength & Mobility Flow',
      duration: '25 mins',
      level: 'Intermediate',
      icon: Icons.self_improvement_rounded,
      iconColor: Colors.indigo,
    ),
  ];

  // ── Cardio workouts ──────────────────────────────────────────────────────
  static const _cardioWorkouts = [
    _WorkoutItem(
      title: 'Boxing Bag Shred',
      duration: '30 mins',
      level: 'All Levels',
      icon: Icons.sports_mma_rounded,
      iconColor: Color(0xFFE53935),
    ),
  ];

  List<_WorkoutItem> get _filteredLevelWorkouts {
    if (_selectedLevel == 0) return _levelWorkouts;
    final levelName = _levels[_selectedLevel];
    return _levelWorkouts.where((w) => w.level == levelName).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLightGrey,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildSection('Popular Gym Workout', _popularWorkouts),
            _buildHiitBanner(),
            _buildGymLevelSection(),
            _buildBodyFocusSection(),
            _buildWorkoutSection('Strength & Conditioning', _strengthWorkouts),
            _buildWorkoutSection('Cardio & Stress Relief', _cardioWorkouts),
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Discover',
              style: TextStyle(
                color: AppTheme.textDark,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                  )
                ],
              ),
              child: const Icon(Icons.more_vert_rounded,
                  color: AppTheme.textDark, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Bar ───────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: const Row(
            children: [
              Icon(Icons.search_rounded, color: AppTheme.textGrey, size: 20),
              SizedBox(width: 10),
              Text(
                'Search',
                style: TextStyle(
                  color: AppTheme.textGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Generic workout list section ─────────────────────────────────────────
  Widget _buildSection(String title, List<_WorkoutItem> items) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title),
          ...items.map((item) => _WorkoutListTile(item: item)),
        ],
      ),
    );
  }

  // ── HIIT Banner ──────────────────────────────────────────────────────────
  Widget _buildHiitBanner() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  // ── Gym Level Section ────────────────────────────────────────────────────
  Widget _buildGymLevelSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Gym Workout Level'),
          // Filter chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(_levels.length, (i) {
                final active = _selectedLevel == i;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedLevel = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: active
                            ? AppTheme.accentRed
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: active
                            ? [
                                BoxShadow(
                                  color: AppTheme.accentRed.withAlpha(70),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withAlpha(8),
                                  blurRadius: 6,
                                )
                              ],
                      ),
                      child: Text(
                        _levels[i],
                        style: TextStyle(
                          color: active ? Colors.white : AppTheme.textGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          // Filtered list
          ..._filteredLevelWorkouts.map((item) => _WorkoutListTile(item: item)),
        ],
      ),
    );
  }

  // ── Body Focus Section ───────────────────────────────────────────────────
  Widget _buildBodyFocusSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Body Focus Area'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.7,
              children:
                  _bodyFocus.map((f) => _BodyFocusCard(item: f)).toList(),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Named workout section ────────────────────────────────────────────────
  Widget _buildWorkoutSection(String title, List<_WorkoutItem> items) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(title),
          ...items.map((item) => _WorkoutListTile(item: item)),
        ],
      ),
    );
  }

  // ── Section header ───────────────────────────────────────────────────────
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'View All →',
            style: TextStyle(
              color: AppTheme.accentRed,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════
class _WorkoutItem {
  final String title;
  final String duration;
  final String level;
  final IconData icon;
  final Color iconColor;

  const _WorkoutItem({
    required this.title,
    required this.duration,
    required this.level,
    required this.icon,
    required this.iconColor,
  });
}

class _BodyFocusItem {
  final String label;
  final IconData icon;
  final Color color;

  const _BodyFocusItem(this.label, this.icon, this.color);
}

// ═══════════════════════════════════════════════════════════
// WORKOUT LIST TILE
// ═══════════════════════════════════════════════════════════
class _WorkoutListTile extends StatelessWidget {
  final _WorkoutItem item;
  const _WorkoutListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.iconColor.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${item.duration} · ${item.level}',
                    style: const TextStyle(
                      color: AppTheme.textGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textGreyLight, size: 22),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BODY FOCUS CARD
// ═══════════════════════════════════════════════════════════
class _BodyFocusCard extends StatelessWidget {
  final _BodyFocusItem item;
  const _BodyFocusCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [item.color, item.color.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: item.color.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          // Background icon watermark
          Positioned(
            right: -8,
            bottom: -8,
            child: Icon(
              item.icon,
              size: 60,
              color: Colors.white.withAlpha(30),
            ),
          ),
          // Label
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              item.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
