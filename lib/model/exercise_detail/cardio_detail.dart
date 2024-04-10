import 'package:power_tracker/model/exercise.dart';

import 'exercise_detail.dart';

class CardioDetail extends ExerciseDetail {
  int duration; // Duration in minutes
  String? intensity; // e.g., "Low", "Medium", "High"
  double? distance; // Optional, applicable for running, cycling, etc.

  CardioDetail({
    required Exercise exercise,
    required this.duration,
    this.intensity,
    this.distance,
  }) : super(exerciseId: exercise.id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'intensity': intensity,
      'distance': distance,
    };
  }
}
