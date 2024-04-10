abstract class ExerciseDetail {
  String exerciseId;

  ExerciseDetail({required this.exerciseId});

  Map<String, dynamic>
      toMap(); // Abstract method to be implemented by subclasses
}
