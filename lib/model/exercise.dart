class Exercise {
  String id; // Unique identifier
  String name; // Name of the exercise
  String description; // Short description of the exercise
  String category; // e.g., "Strength Training", "Cardio"
  String difficulty; // "Beginner", "Intermediate", "Advanced"
  String? equipmentNeeded; // "None", "Dumbbells", "Resistance Bands", etc.
  String? instructions; // Detailed instructions for performing the exercise
  List<String>? muscleGroups; // List of muscle groups targeted by the exercise

  Exercise(
      {this.id = '',
      required this.name,
      required this.description,
      required this.category,
      required this.difficulty,
      this.equipmentNeeded,
      this.instructions,
      this.muscleGroups});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'equipmentNeeded': equipmentNeeded,
      'instructions': instructions,
      'muscleGroups': muscleGroups,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
        id: map['id'] ?? '',
        name: map['name'],
        description: map['description'],
        category: map['category'],
        difficulty: map['difficulty'],
        equipmentNeeded: map['equipmentNeeded'],
        instructions: map['instructions'],
        muscleGroups: List<String>.from(map['muscleGroups'] ?? []));
  }
}
