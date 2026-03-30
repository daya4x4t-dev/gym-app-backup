import 'package:flutter/material.dart';

// ── CONSTANTS ──────────────────────────────────────────────────────────────────
const kRed = Color(0xFFE8192C);
const kDark = Color(0xFF1C1C1E);
const kGrey = Color(0xFFF5F5F5);
const kBorder = Color(0xFFEFEFEF);
const kTextSub = Color(0xFF888888);

// ── DATA MODELS ────────────────────────────────────────────────────────────────
class ClashCard {
  final String emoji;
  final String title;
  final String duration;
  final String level;
  final String distance;
  final Color bgColor;

  const ClashCard({
    required this.emoji,
    required this.title,
    required this.duration,
    required this.level,
    required this.distance,
    required this.bgColor,
  });
}

class LeaderboardEntry {
  final String medal;
  final String initials;
  final String name;
  final String points;
  final bool isYou;

  const LeaderboardEntry({
    required this.medal,
    required this.initials,
    required this.name,
    required this.points,
    this.isYou = false,
  });
}

class MyClashEntry {
  final String emoji;
  final String title;
  final String daysLeft;
  final double progress;

  const MyClashEntry({
    required this.emoji,
    required this.title,
    required this.daysLeft,
    required this.progress,
  });
}

// ── MAIN SCREEN ────────────────────────────────────────────────────────────────
class LocalClashScreen extends StatefulWidget {
  const LocalClashScreen({super.key});

  @override
  State<LocalClashScreen> createState() => _LocalClashScreenState();
}

class _LocalClashScreenState extends State<LocalClashScreen> {
  int _selectedTab = 0;
  int _selectedNavIndex = 2;

  final List<String> _filterTabs = ['All', 'Open', 'Invite-Only', 'Ended'];

  final List<ClashCard> _nearbyClashes = const [
    ClashCard(
      emoji: '🏋️',
      title: 'CrossFit Throwdown',
      duration: '50 mins',
      level: 'Advanced',
      distance: '1.2 km away',
      bgColor: Color(0xFF2D2D2D),
    ),
    ClashCard(
      emoji: '🥊',
      title: 'Boxing Battle',
      duration: '30 mins',
      level: 'All Levels',
      distance: '3.5 km away',
      bgColor: Color(0xFF1A1A2E),
    ),
    ClashCard(
      emoji: '💪',
      title: 'Deadlift Duel',
      duration: '45 mins',
      level: 'Intermediate',
      distance: '5 km away',
      bgColor: Color(0xFF1C2A1C),
    ),
  ];

  final List<LeaderboardEntry> _leaderboard = const [
    LeaderboardEntry(medal: '🥇', initials: 'AM', name: 'Alex M.', points: '1,240 pts'),
    LeaderboardEntry(medal: '🥈', initials: 'PR', name: 'Priya R.', points: '1,185 pts'),
    LeaderboardEntry(medal: '🥉', initials: 'You', name: 'You', points: '980 pts', isYou: true),
  ];

  final List<MyClashEntry> _myClashes = const [
    MyClashEntry(emoji: '🏆', title: 'City Iron Wars', daysLeft: '3 days remaining', progress: 0.65),
    MyClashEntry(emoji: '🥊', title: 'Boxing Battle', daysLeft: '1 day remaining', progress: 0.88),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(),
                    _buildSearchBar(),
                    _buildHeroBanner(),
                    _buildSectionHeader('Nearby Clashes'),
                    _buildNearbyClashes(),
                    _buildFilterTabs(),
                    _buildSectionHeader('Leaderboard'),
                    _buildLeaderboard(),
                    _buildSectionHeader('My Clashes'),
                    _buildMyClashes(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── TOP BAR ────────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Red circle + icon
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kRed, width: 2),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: kRed, size: 16),
            ),
          ),
          const Text(
            'Local Clash',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF111111)),
          ),
          const Icon(Icons.more_vert, color: Color(0xFF555555), size: 22),
        ],
      ),
    );
  }

  // ── SEARCH BAR ─────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: kGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFFAAAAAA), size: 18),
            const SizedBox(width: 8),
            Text(
              'Search tournaments...',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // ── HERO BANNER ────────────────────────────────────────────────────────────
  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        decoration: BoxDecoration(
          color: kDark,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Decorative right side gradient
            Positioned(
              top: 0, right: 0, bottom: 0,
              child: Container(
                width: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x002A2A2A), Color(0x803A2A1A)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LIVE badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: kRed,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🔴  LIVE NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'City Iron Wars',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),

                  const Text(
                    'Ends in 2d 14h  •  340 participants',
                    style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 12),
                  ),
                  const SizedBox(height: 14),

                  // ✅ RIGHT ALIGNED BUTTON
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                        decoration: BoxDecoration(
                          color: kRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Join Clash →',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ── SECTION HEADER ─────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
          ),
          const Text(
            'View All →',
            style: TextStyle(fontSize: 13, color: kRed, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ── NEARBY CLASHES ─────────────────────────────────────────────────────────
  Widget _buildNearbyClashes() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        itemCount: _nearbyClashes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final c = _nearbyClashes[i];
          return _ClashNearbyCard(clash: c);
        },
      ),
    );
  }

  // ── FILTER TABS ────────────────────────────────────────────────────────────
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: List.generate(_filterTabs.length, (i) {
          final selected = i == _selectedTab;
          return Padding(
            padding: EdgeInsets.only(right: i < _filterTabs.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: selected ? kRed : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: selected ? kRed : const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  _filterTabs[i],
                  style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF555555),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── LEADERBOARD ────────────────────────────────────────────────────────────
  Widget _buildLeaderboard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            ..._leaderboard.asMap().entries.map((e) {
              final idx = e.key;
              final entry = e.value;
              return Column(
                children: [
                  _LeaderboardRow(entry: entry),
                  if (idx < _leaderboard.length - 1)
                    const Divider(color: Color(0xFFEFEFEF), height: 1),
                ],
              );
            }),
            const SizedBox(height: 10),
            const Text(
              'View Full Leaderboard →',
              style: TextStyle(fontSize: 13, color: kRed, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // ── MY CLASHES ─────────────────────────────────────────────────────────────
  Widget _buildMyClashes() {
    return Column(
      children: _myClashes.map((c) => _MyClashCard(clash: c)).toList(),
    );
  }

  // ── BOTTOM NAV ─────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Discover'},
      {'icon': Icons.swap_vert, 'label': 'Clash'},
      {'icon': Icons.access_time_outlined, 'label': 'History'},
      {'icon': Icons.person_outline, 'label': 'Account'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: kBorder, width: 1)),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == _selectedNavIndex;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedNavIndex = i);
              if (i == 0) {
                Navigator.pop(context); // Go back home
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  items[i]['icon'] as IconData,
                  color: selected ? kRed : const Color(0xFFAAAAAA),
                  size: 22,
                ),
                const SizedBox(height: 3),
                Text(
                  items[i]['label'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: selected ? kRed : const Color(0xFFAAAAAA),
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ── NEARBY CLASH CARD WIDGET ───────────────────────────────────────────────────
class _ClashNearbyCard extends StatelessWidget {
  final ClashCard clash;
  const _ClashNearbyCard({required this.clash});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Container(
            width: double.infinity,
            height: 100,
            color: clash.bgColor,
            child: Center(
              child: Text(clash.emoji, style: const TextStyle(fontSize: 36)),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clash.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
                ),
                const SizedBox(height: 2),
                Text(
                  '${clash.duration} • ${clash.level}',
                  style: const TextStyle(fontSize: 11, color: kTextSub),
                ),
                const SizedBox(height: 2),
                Text(
                  '📍 ${clash.distance}',
                  style: const TextStyle(fontSize: 11, color: kRed, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── LEADERBOARD ROW WIDGET ────────────────────────────────────────────────────
class _LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  const _LeaderboardRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Medal
          SizedBox(
            width: 28,
            child: Text(entry.medal, style: const TextStyle(fontSize: 18), textAlign: TextAlign.center),
          ),
          const SizedBox(width: 10),
          // Avatar
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: entry.isYou ? kRed : const Color(0xFFDDDDDD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                entry.initials,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: entry.isYou ? Colors.white : const Color(0xFF555555),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Name
          Expanded(
            child: Text(
              entry.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: entry.isYou ? kRed : const Color(0xFF111111),
              ),
            ),
          ),
          // Score
          Text(
            entry.points,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: entry.isYou ? kRed : const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

// ── MY CLASH CARD WIDGET ──────────────────────────────────────────────────────
class _MyClashCard extends StatelessWidget {
  final MyClashEntry clash;
  const _MyClashCard({required this.clash});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorder, width: 1.5),
      ),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: kGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(clash.emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          // Info + progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clash.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
                ),
                const SizedBox(height: 4),
                Text(
                  clash.daysLeft,
                  style: const TextStyle(fontSize: 11, color: kTextSub),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: clash.progress,
                    backgroundColor: const Color(0xFFEFEFEF),
                    valueColor: const AlwaysStoppedAnimation<Color>(kRed),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 22),
        ],
      ),
    );
  }
}
