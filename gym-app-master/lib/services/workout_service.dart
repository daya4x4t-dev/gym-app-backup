import 'api_service.dart';

class WorkoutService {
  final _api = ApiService.instance;

  Future<dynamic> getWorkouts() => _api.get('/api/workouts');
  Future<dynamic> addWorkout(Map<String, dynamic> data) =>
      _api.post('/api/workouts', body: data);
  Future<dynamic> updateWorkout(String workoutId, Map<String, dynamic> data) =>
      _api.put('/api/workouts/$workoutId', body: data);
  Future<dynamic> deleteWorkout(String workoutId) =>
      _api.delete('/api/workouts/$workoutId');
}
