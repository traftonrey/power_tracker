import 'exercise_detail.dart';
import '../exercise.dart';

class StrengthTrainingDetail extends ExerciseDetail {
  int sets; // Number of sets
  int reps; // Number of repetitions
  double? weight; // Weight, can be null if the exercise is bodyweight

  StrengthTrainingDetail({
    required Exercise exercise,
    required this.sets,
    required this.reps,
    this.weight,
  }) : super(exerciseId: exercise.id);

  @override
  Map<String, dynamic> toMap() {
    return {'sets': sets, 'reps': reps, 'weight': weight};
  }
}
