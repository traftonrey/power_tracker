import 'package:flutter/material.dart';
import 'package:power_tracker/widgets/navigation/scaffold.dart';

class CreateWorkoutScreen extends StatelessWidget {
  const CreateWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: _createWorkout(), currentIndex: 1);
  }

  Widget _createWorkout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout'),
      ),
      body: const Center(
        child: Text('Form to create workout goes here'),
      ),
    );
  }
}
