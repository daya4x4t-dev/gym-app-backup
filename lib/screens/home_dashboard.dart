import 'package:flutter/material.dart';
import 'package:gym/screens/activity_progress_screen.dart';

const _accentRed = Color(0xFFE53935);
const _bgLight = Color(0xFFF8F9FA);
const _textDark = Color(0xFF1A1A1A);
const _textGrey = Color(0xFF757575);

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section
              _buildHeader(),

              // 2. Greeting Section
              _buildGreeting(),

              // 3. Search Bar
              _buildSearchBar(),

              // 4. Featured Banner
              _buildFeaturedBanner(),

              // 5. Stats & Equipment Group (White Card)
              _buildStatsGroup(),

              // 6. Top Gym Brands
              _buildSectionHeader('Top Gym Brand'),
              _buildBrandList(),

              // 7. Top Workout Section
              _buildSectionHeader('Top Workout'),
              _buildWorkoutsGrid(),

              const SizedBox(height: 120), // Extra space for floating nav
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _accentRed.withAlpha(51), width: 2),
            ),
            child: const CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFEEEEEE),
              child: Icon(Icons.person, color: _textGrey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'B.Dayanithi',
                  style: TextStyle(
                    color: _textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: _accentRed, size: 14),
                    SizedBox(width: 2),
                    Text(
                      'Dubai, UAE',
                      style: TextStyle(
                        color: _textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Good Morning',
            style: TextStyle(
              color: _textDark,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Ready for today’s workout?',
            style: TextStyle(
              color: _textGrey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.search_rounded, color: _textGrey, size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search workouts, gyms or equipment',
                      style: TextStyle(color: _textGrey, fontSize: 13, fontWeight: FontWeight.w500),
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
              color: _accentRed,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _accentRed.withAlpha(102),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBanner() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: _textDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(31),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FEATURED PROGRAM'.toUpperCase(),
                style: const TextStyle(
                  color: _accentRed,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Top Workouts\nof 2025',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentRed,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGroup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: const [
                  _StatSmallCard(icon: Icons.favorite_rounded, label: 'Heart Rate', color: Color(0xFFFFF1F1), iconColor: Colors.red),
                  SizedBox(width: 15),
                  _StatSmallCard(icon: Icons.local_fire_department_rounded, label: 'Calories', color: Color(0xFFFFF7EF), iconColor: Colors.orange),
                  SizedBox(width: 15),
                  _StatSmallCard(icon: Icons.directions_walk_rounded, label: 'Steps', color: Color(0xFFF1FFF1), iconColor: Colors.green),
                  SizedBox(width: 15),
                  _StatSmallCard(icon: Icons.monitor_weight_rounded, label: 'Weight', color: Color(0xFFF1F7FF), iconColor: Colors.blue),
                  SizedBox(width: 15),
                  _StatSmallCard(icon: Icons.restaurant_menu_rounded, label: 'Diet Plan', color: Color(0xFFFFFDE3), iconColor: Colors.amber),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.fitness_center_rounded, color: _accentRed, size: 22),
                label: const Text(
                  'View Gym Equipment',
                  style: TextStyle(
                    color: _accentRed,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF5F5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _textDark,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'View All',
            style: TextStyle(
              color: _accentRed,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: const [
          _BrandItem(name: 'Life Fitness', icon: Icons.bolt_rounded),
          _BrandItem(name: 'Technogym', icon: Icons.sports_gymnastics_rounded),
          _BrandItem(name: 'Rogue', icon: Icons.fitness_center_rounded),
          _BrandItem(name: 'Energy Fitness', icon: Icons.electric_bolt_rounded),
          _BrandItem(name: 'NordicTrack', icon: Icons.run_circle_rounded),
        ],
      ),
    );
  }

  Widget _buildWorkoutsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
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
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_filled, 'Home', isActive: true, context: context),
                _buildNavItem(Icons.explore_outlined, 'Explore', context: context),
                const SizedBox(width: 65), // Space for floating button
                _buildNavItem(
                  Icons.analytics_outlined,
                  'Stats',
                  context: context,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ActivityProgressScreen()),
                    );
                  },
                ),
                _buildNavItem(Icons.person_outline_rounded, 'Profile', context: context),
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: Column(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: _accentRed,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _accentRed.withAlpha(102),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const Icon(
                    Icons.auto_fix_high_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'AI Trainer',
                  style: TextStyle(
                    color: _textGrey,
                    fontSize: 11,
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

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false, BuildContext? context, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? _accentRed : Colors.grey.shade400,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? _accentRed : _textGrey,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10),
        ],
      ),
      child: Icon(icon, color: _textDark, size: 24),
    );
  }
}

class _StatSmallCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;

  const _StatSmallCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF757575),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _BrandItem extends StatelessWidget {
  final String name;
  final IconData icon;

  const _BrandItem({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10),
              ],
              border: Border.all(color: Colors.grey.shade50),
            ),
            child: Center(
              child: Icon(icon, color: Colors.grey.shade400, size: 30),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

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
        borderRadius: BorderRadius.circular(28),
        color: _textDark.withAlpha(230),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [Colors.black.withAlpha(217), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.white, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    tag.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$level • $duration',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

