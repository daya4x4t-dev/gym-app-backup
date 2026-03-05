import 'package:shared_preferences/shared_preferences.dart';

/// Simple persistence helper for onboarding state.
///
///  isNewUser()          → true if the user hasn't completed onboarding yet
///  setNewUser()         → call after signup success so next login shows flow
///  markOnboardingDone() → call when user finishes the last onboarding step
class OnboardingService {
  static const _keyNewUser = 'is_new_user';

  /// Returns true if the signed-in user still needs onboarding.
  static Future<bool> isNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNewUser) ?? false;
  }

  /// Mark the current user as "new" (call this right after signup).
  static Future<void> setNewUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNewUser, true);
  }

  /// Call when all onboarding steps are completed.
  static Future<void> markOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNewUser, false);
  }
}
