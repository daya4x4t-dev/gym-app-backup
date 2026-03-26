import 'dart:convert';
import 'dart:io';

import 'api_service.dart';

class ProfileService {
  final _api = ApiService.instance;

  Future<Map<String, dynamic>> getProfile() async {
    final res = await _api.get('/api/user/profile');
    return (res['data'] as Map?)?.cast<String, dynamic>() ?? {};
  }

  Future<Map<String, dynamic>> getProgress() async {
    final res = await _api.get('/api/user/progress');
    return (res['data'] as Map?)?.cast<String, dynamic>() ?? {};
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final res = await _api.put('/api/user/profile', body: data);
    return (res['data'] as Map?)?.cast<String, dynamic>() ?? {};
  }

  Future<void> uploadPhoto(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    await updateProfile({'profileImage': base64Encode(bytes)});
  }
}
