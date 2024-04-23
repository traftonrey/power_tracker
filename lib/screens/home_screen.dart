import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:power_tracker/widgets/navigation/scaffold.dart';
import 'workout_details_screen.dart';
import 'create_workout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: _buildWorkoutsList(),
      currentIndex: 0,
    );
  }

  Widget _buildWorkoutsList() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(child: Text("Please sign in to view your workouts."));
    }
    final userId = user.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('workouts')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'No workouts found. Create your first workout plan!'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => CreateWorkoutScreen()));
                  },
                  child: const Text('Create Workout'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot workout = snapshot.data!.docs[index];
            return ListTile(
              title: Text(workout['name']),
              subtitle: Text(
                  'Sets: ${workout['sets']}, Reps: ${workout['reps']}, Weight: ${workout['weight']}kg'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkoutDetailsScreen(
                        userId: userId, workoutId: workout.id)),
              ),
            );
          },
        );
      },
    );
  }
}
