import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // =========================
  // 🔐 SIGNUP
  // =========================
  Future<void> signup(String username, String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': username,
        },
      );

      if (response.user == null) {
        throw Exception("Signup failed");
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  // =========================
  // 🔐 LOGIN
  // =========================
  Future<void> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Login failed");
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  // =========================
  // 🔐 LOGOUT
  // =========================
  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  // =========================
  // 🔐 FORGOT PASSWORD (RESET LINK)
  // =========================
  Future<void> forgotPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Failed to send reset link");
    }
  }

  // =========================
  // 🔐 CURRENT USER
  // =========================
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  // =========================
  // 🔐 SESSION
  // =========================
  Session? getSession() {
    return supabase.auth.currentSession;
  }
}