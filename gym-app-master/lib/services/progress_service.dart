import 'api_service.dart';

class ProgressService {
  final _api = ApiService.instance;

  Future<dynamic> getProgress() => _api.get('/api/progress');
  Future<dynamic> logProgress(Map<String, dynamic> data) =>
      _api.post('/api/progress', body: data);
  Future<dynamic> getLatestProgress() => _api.get('/api/progress/latest');
  Future<dynamic> deleteProgress(String progressId) =>
      _api.delete('/api/progress/$progressId');
}
