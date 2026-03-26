import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // ✅ LOGIN
  Future<void> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ✅ SIGNUP
  Future<void> signup(String name, String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ✅ LOGOUT
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // ✅ FORGOT PASSWORD
  Future<void> forgotPassword(String email) async {
    try {
      final String redirectTo = kIsWeb
          ? 'http://localhost:3000/#/reset-password'
          : 'myapp://reset-password';

      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: redirectTo,
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Failed to send reset link: $e");
    }
  }

  // ✅ UPDATE PASSWORD
  Future<void> updatePassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }
}