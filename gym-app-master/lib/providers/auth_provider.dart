import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  bool isAuthenticated = false;

  Future<void> initialize() async {
    isAuthenticated = await _authService.hasSession();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.login(email, password);
      isAuthenticated = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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

  Future<void> logout() async {
    await _authService.logout();
    isAuthenticated = false;
    notifyListeners();
  }
}
