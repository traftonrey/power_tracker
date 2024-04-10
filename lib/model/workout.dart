import 'exercise_detail/exercise_detail.dart';

class Workout {
  String id;
  String userId;
  DateTime dateLastUpdated;
  String name;
  List<ExerciseDetail> exercises = [];

  Workout({
    this.id = '',
    required this.userId,
    required this.dateLastUpdated,
    required this.name,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'dateLastUpdated': dateLastUpdated.toIso8601String(),
      'name': name,
      'exercises': exercises.map((detail) => detail.toMap()).toList(),
    };
  }
}
