import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/profile_service.dart';
import '../widgets/fitness_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';
import 'edit_profile_screen.dart';
import 'reset_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService _profileService = ProfileService();
  bool _isLoading = true;
  bool _notifications = true;
  bool _darkMode = true;
  Map<String, dynamic> _profile = {};
  Map<String, dynamic> _progress = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final profile = await _profileService.getProfile();
      final progress = await _profileService.getProgress();
      if (!mounted) return;
      setState(() {
        _profile = profile;
        _progress = progress;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profile')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;

    try {
      await _profileService.uploadPhoto(File(file.path));
      await _loadProfile();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final name = (_profile['name'] ?? 'New User').toString();
    final email = (_profile['email'] ?? 'No email').toString();
    final height = _profile['height'];
    final weight = _profile['weight'];
    final bmi = _profile['bmi'];

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: RefreshIndicator(
        onRefresh: _loadProfile,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProfileHeader(
              name: name,
              email: email,
              imageUrl: _profile['profileImage']?.toString(),
              onEdit: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              ).then((_) => _loadProfile()),
              onImageTap: _pickImage,
            ),
            FitnessCard(
              title: 'Fitness Info',
              children: [
                Text('Height: ${height ?? '-'} cm'),
                Text('Weight: ${weight ?? '-'} kg'),
                Text('Goal: ${_profile['goal'] ?? 'Maintain'}'),
                Text('BMI: ${bmi ?? '-'}'),
              ],
            ),
            FitnessCard(
              title: 'Progress',
              children: [
                Text('Weight history entries: ${(_progress['weightHistory'] as List?)?.length ?? 0}'),
                Text('Workout streak: ${_progress['workoutStreak'] ?? 0} days'),
                Text('Calories burned: ${_progress['caloriesBurned'] ?? 0} kcal'),
              ],
            ),
            FitnessCard(
              title: 'Subscription',
              children: [
                Text('Plan: ${_profile['subscriptionPlan'] ?? 'Free'}'),
                Text('Expiry: ${_profile['subscriptionExpiry'] ?? 'N/A'}'),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Upgrade Plan')),
              ],
            ),
            Card(
              child: Column(
                children: [
                  SettingsTile(
                    title: 'Edit profile',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                    ).then((_) => _loadProfile()),
                  ),
                  SettingsTile(
                    title: 'Change password',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
                    ),
                  ),
                  SettingsTile(
                    title: 'Notifications',
                    trailing: Switch(
                      value: _notifications,
                      onChanged: (v) => setState(() => _notifications = v),
                    ),
                  ),
                  SettingsTile(
                    title: 'Dark mode',
                    trailing: Switch(
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                  ),
                  SettingsTile(
                    title: 'Logout',
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                    },
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
