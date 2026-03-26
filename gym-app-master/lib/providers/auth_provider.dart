import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  // 🔐 LOGIN
  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.login(email, password);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🔐 SIGNUP
  Future<void> signup(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.signup(name, email, password);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🔐 LOGOUT
  Future<void> logout() async {
    await _authService.logout();
  }
}