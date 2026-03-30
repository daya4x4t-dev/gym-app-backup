import 'package:flutter/material.dart';
import 'package:gym/utils/app_theme.dart';

// ─── Settings Screen ─────────────────────────────────────────────────────────

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ── Toggle states ──────────────────────────────────────────────────────────
  bool _aiSuggestions      = true;
  bool _goalReminders      = true;
  bool _heartRateTracking  = true;
  bool _calorieTracking    = true;
  bool _stepCounterSync    = false;
  bool _workoutReminders   = true;
  bool _dailyTips          = false;
  bool _progressUpdates    = true;
  bool _aiAlerts           = true;
  bool _darkMode           = false;

  // ── Selection states ───────────────────────────────────────────────────────
  String _difficultyLevel  = 'Intermediate';
  String _workoutType      = 'Strength';
  String _units            = 'kg';
  // ignore: prefer_final_fields
  String _language         = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProfileCard(),
                const SizedBox(height: 20),
                _buildSection(
                  title: 'Workout Preferences',
                  icon: Icons.fitness_center_rounded,
                  iconColor: AppTheme.accentRed,
                  children: [
                    _buildInfoTile(
                      icon: Icons.timer_outlined,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Default Duration',
                      value: '45 min',
                      onTap: () => _showPickerSheet(
                        context,
                        title: 'Workout Duration',
                        options: ['15 min', '30 min', '45 min', '60 min', '90 min'],
                        selected: '45 min',
                      ),
                    ),
                    _buildDivider(),
                    _buildChipSelectorTile(
                      icon: Icons.trending_up_rounded,
                      iconBg: const Color(0xFFFFF4EC),
                      iconColor: const Color(0xFFFF6D00),
                      label: 'Difficulty Level',
                      options: const ['Beginner', 'Intermediate', 'Advanced'],
                      selected: _difficultyLevel,
                      onChanged: (v) => setState(() => _difficultyLevel = v),
                    ),
                    _buildDivider(),
                    _buildChipSelectorTile(
                      icon: Icons.sports_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Workout Type',
                      options: const ['Strength', 'Cardio', 'Yoga', 'HIIT'],
                      selected: _workoutType,
                      onChanged: (v) => setState(() => _workoutType = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.auto_fix_high_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'AI Trainer Suggestions',
                      subtitle: 'Get smart workout recommendations',
                      value: _aiSuggestions,
                      onChanged: (v) => setState(() => _aiSuggestions = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Fitness Goals',
                  icon: Icons.flag_rounded,
                  iconColor: const Color(0xFFFF6D00),
                  children: [
                    _buildInfoTile(
                      icon: Icons.directions_walk_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Daily Step Goal',
                      value: '10,000 steps',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.calendar_today_rounded,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Weekly Workout Target',
                      value: '5 days',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.monitor_weight_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'Weight Goal',
                      value: '75 kg',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.notifications_active_rounded,
                      iconBg: const Color(0xFFFFFDE8),
                      iconColor: const Color(0xFFFFA000),
                      label: 'Goal Reminders',
                      subtitle: 'Get nudged when you\'re off track',
                      value: _goalReminders,
                      onChanged: (v) => setState(() => _goalReminders = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Health & Tracking',
                  icon: Icons.favorite_rounded,
                  iconColor: AppTheme.accentRed,
                  children: [
                    _buildToggleTile(
                      icon: Icons.favorite_rounded,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Heart Rate Tracking',
                      subtitle: 'Monitor BPM during workouts',
                      value: _heartRateTracking,
                      onChanged: (v) => setState(() => _heartRateTracking = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.local_fire_department_rounded,
                      iconBg: const Color(0xFFFFF4EC),
                      iconColor: const Color(0xFFFF6D00),
                      label: 'Calorie Tracking',
                      subtitle: 'Log intake and burn data',
                      value: _calorieTracking,
                      onChanged: (v) => setState(() => _calorieTracking = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.directions_walk_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Step Counter Sync',
                      subtitle: 'Sync steps from phone sensors',
                      value: _stepCounterSync,
                      onChanged: (v) => setState(() => _stepCounterSync = v),
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.watch_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'Connect Wearable Device',
                      subtitle: 'Link smartwatch or fitness band',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Notifications',
                  icon: Icons.notifications_rounded,
                  iconColor: const Color(0xFFFFA000),
                  children: [
                    _buildToggleTile(
                      icon: Icons.alarm_rounded,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Workout Reminders',
                      subtitle: 'Remind me before scheduled sessions',
                      value: _workoutReminders,
                      onChanged: (v) => setState(() => _workoutReminders = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.lightbulb_rounded,
                      iconBg: const Color(0xFFFFFDE8),
                      iconColor: const Color(0xFFFFA000),
                      label: 'Daily Fitness Tips',
                      subtitle: 'Morning tips to stay motivated',
                      value: _dailyTips,
                      onChanged: (v) => setState(() => _dailyTips = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.bar_chart_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Progress Updates',
                      subtitle: 'Weekly summary of your activity',
                      value: _progressUpdates,
                      onChanged: (v) => setState(() => _progressUpdates = v),
                    ),
                    _buildDivider(),
                    _buildToggleTile(
                      icon: Icons.auto_fix_high_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'AI Trainer Alerts',
                      subtitle: 'Get feedback from your AI trainer',
                      value: _aiAlerts,
                      onChanged: (v) => setState(() => _aiAlerts = v),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'App Preferences',
                  icon: Icons.tune_rounded,
                  iconColor: const Color(0xFF3949AB),
                  children: [
                    _buildToggleTile(
                      icon: Icons.dark_mode_rounded,
                      iconBg: const Color(0xFF1C1C2E),
                      iconColor: Colors.white,
                      label: 'Dark Mode',
                      subtitle: 'Switch to dark theme',
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                    _buildDivider(),
                    _buildChipSelectorTile(
                      icon: Icons.monitor_weight_outlined,
                      iconBg: const Color(0xFFFFF4EC),
                      iconColor: const Color(0xFFFF6D00),
                      label: 'Units',
                      options: const ['kg', 'lbs'],
                      selected: _units,
                      onChanged: (v) => setState(() => _units = v),
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.language_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Language',
                      value: _language,
                      onTap: () => _showPickerSheet(
                        context,
                        title: 'Language',
                        options: const ['English', 'Arabic', 'Hindi', 'French', 'Spanish'],
                        selected: _language,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Membership & Subscription',
                  icon: Icons.workspace_premium_rounded,
                  iconColor: const Color(0xFFFFA000),
                  children: [
                    _buildMembershipCard(),
                    const SizedBox(height: 12),
                    _buildActionTile(
                      icon: Icons.rocket_launch_rounded,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Upgrade Plan',
                      subtitle: 'Unlock all premium features',
                      onTap: () {},
                      trailingChip: 'PRO',
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.receipt_long_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'Payment History',
                      subtitle: 'View past transactions',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Privacy & Data',
                  icon: Icons.shield_rounded,
                  iconColor: const Color(0xFF2E7D32),
                  children: [
                    _buildActionTile(
                      icon: Icons.health_and_safety_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Health Data Permissions',
                      subtitle: 'Manage what data we access',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.download_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'Export Fitness Data',
                      subtitle: 'Download your data as CSV',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.delete_forever_rounded,
                      iconBg: const Color(0xFFFFF0F0),
                      iconColor: AppTheme.accentRed,
                      label: 'Delete Account',
                      subtitle: 'Permanently remove your data',
                      onTap: () => _showDeleteConfirmation(context),
                      labelColor: AppTheme.accentRed,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  title: 'Support',
                  icon: Icons.support_agent_rounded,
                  iconColor: const Color(0xFF3949AB),
                  children: [
                    _buildActionTile(
                      icon: Icons.help_outline_rounded,
                      iconBg: const Color(0xFFEDF9F0),
                      iconColor: const Color(0xFF2E7D32),
                      label: 'Help Center',
                      subtitle: 'FAQs and guides',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.person_pin_circle_rounded,
                      iconBg: const Color(0xFFFFF4EC),
                      iconColor: const Color(0xFFFF6D00),
                      label: 'Contact Trainer',
                      subtitle: 'Chat with your assigned trainer',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildActionTile(
                      icon: Icons.info_outline_rounded,
                      iconBg: const Color(0xFFEEF3FF),
                      iconColor: const Color(0xFF3949AB),
                      label: 'About the App',
                      subtitle: 'Version 2.1.0',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Sign out button
                _buildSignOutButton(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Sliver App Bar ─────────────────────────────────────────────────────────
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 60,
      floating: true,
      snap: true,
      pinned: false,
      backgroundColor: AppTheme.bgLight,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppTheme.textDarkAlt, size: 18),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.only(left: 50, bottom: 10),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppTheme.textDarkAlt,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // ─── Profile Card ────────────────────────────────────────────────────────────

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentRed.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(color: AppTheme.accentRed, width: 2.5),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFEEEEEE),
              child: Icon(Icons.person_rounded, color: AppTheme.textGreyAlt, size: 32),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'B.Dayanithi',
                  style: TextStyle(
                    color: AppTheme.textDarkAlt,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.accentRed, AppTheme.accentRedDark],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PRO MEMBER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Since Jan 2024',
                      style: TextStyle(
                        color: AppTheme.textGreyAlt,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Edit button
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: AppTheme.accentRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: AppTheme.accentRed,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section Wrapper ─────────────────────────────────────────────────────────
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 7),
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: iconColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        // Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // ─── Tile helpers ────────────────────────────────────────────────────────────

  Widget _buildToggleTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _iconBox(icon, iconBg, iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      color: AppTheme.textDarkAlt,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                      color: AppTheme.textGreyAlt,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppTheme.accentRed.withValues(alpha: 0.25),
              thumbColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? AppTheme.accentRed
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _iconBox(icon, iconBg, iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                    color: AppTheme.textDarkAlt,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Text(value,
                style: const TextStyle(
                  color: AppTheme.textGreyAlt,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textGreyAlt, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
    Color? labelColor,
    String? trailingChip,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _iconBox(icon, iconBg, iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                        color: labelColor ?? AppTheme.textDarkAlt,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                        color: AppTheme.textGreyAlt,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
            if (trailingChip != null) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.accentRed, AppTheme.accentRedDark],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  trailingChip,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
            const Icon(Icons.chevron_right_rounded,
                color: AppTheme.textGreyAlt, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSelectorTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _iconBox(icon, iconBg, iconColor),
              const SizedBox(width: 14),
              Text(label,
                  style: const TextStyle(
                    color: AppTheme.textDarkAlt,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: options.map((opt) {
              final isSelected = opt == selected;
              return GestureDetector(
                onTap: () => onChanged(opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.accentRed : const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppTheme.accentRed.withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    opt,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.textGreyAlt,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ─── Membership Card ──────────────────────────────────────────────────────────
  Widget _buildMembershipCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C2E), Color(0xFF2D1B1B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.accentRed.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.workspace_premium_rounded,
                color: AppTheme.accentRed, size: 26),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pro Plan — Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 3),
                Text('Renews on Apr 12, 2026',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: AppTheme.accentRed,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentRed.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text('Manage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ],
      ),
    );
  }

  // ─── Sign Out Button ──────────────────────────────────────────────────────────
  Widget _buildSignOutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.accentRed.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppTheme.accentRed.withValues(alpha: 0.2),
            width: 1.2,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppTheme.accentRed, size: 20),
            SizedBox(width: 10),
            Text('Sign Out',
                style: TextStyle(
                  color: AppTheme.accentRed,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                )),
          ],
        ),
      ),
    );
  }

  // ─── Shared helpers ───────────────────────────────────────────────────────────

  Widget _iconBox(IconData icon, Color bg, Color color) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 72,
      endIndent: 16,
      color: Colors.grey.withValues(alpha: 0.12),
    );
  }

  // ─── Bottom sheets / dialogs ──────────────────────────────────────────────────

  void _showPickerSheet(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String selected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(
                  color: AppTheme.textDarkAlt,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                )),
            const SizedBox(height: 16),
            ...options.map((opt) {
              final isSelected = opt == selected;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(opt,
                    style: TextStyle(
                      color: isSelected ? AppTheme.accentRed : AppTheme.textDarkAlt,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      fontSize: 15,
                    )),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded,
                        color: AppTheme.accentRed, size: 22)
                    : null,
                onTap: () => Navigator.pop(context),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete Account',
            style:
                TextStyle(color: AppTheme.textDarkAlt, fontWeight: FontWeight.w800)),
        content: const Text(
          'This action is permanent and cannot be undone. All your fitness data will be erased.',
          style: TextStyle(color: AppTheme.textGreyAlt, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(
                    color: AppTheme.textGreyAlt, fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentRed,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Delete',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
