import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_tracker/widgets/navigation/scaffold.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final String userId;
  final String? workoutId;

  const WorkoutDetailsScreen({super.key, required this.userId, this.workoutId});

  @override
  _WorkoutDetailsScreenState createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (widget.workoutId != null) {
      _fetchWorkoutData();
    }
  }

  void _fetchWorkoutData() async {
    // Assuming you're using a structure where each user has their workouts
    // in a subcollection under a document with their userId in a 'workouts' collection
    var workoutSnapshot = await _firestore
        .collection('workouts')
        .doc(widget.userId)
        .collection('userWorkouts')
        .doc(widget.workoutId)
        .get();

    if (workoutSnapshot.exists) {
      // Use this data to pre-populate your form fields or handle accordingly
      // This is just a placeholder for whatever operation you need to perform with the workout data
      print('Workout data fetched successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: _viewWorkout(), currentIndex: 1);
  }
}

Widget _viewWorkout() {
  final user = FirebaseAuth.instance.currentUser;
  return Scaffold(
    appBar: AppBar(
      title: const Text('Workout Details'),
    ),
    body: Center(
      child: Text('Workout Details for User: ${user?.uid ?? 'None'}'),
    ),
  );
}
