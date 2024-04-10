import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'workout_details_screen.dart'; // Update this path as necessary
import 'create_workout_screen.dart'; // Assuming you have this screen for creating workouts

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // For bottom navigation bar
  final user = FirebaseAuth.instance.currentUser;

  List<Widget> _widgetOptions() => [
        _buildWorkoutsList(),
        CreateWorkoutScreen(), // Your screen for creating workouts
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BuiltBuddy'),
      ),
      body: _widgetOptions().elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create Workout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildWorkoutsList() {
    if (user == null) {
      return Center(child: Text("Please sign in to view your workouts."));
    }
    final userId = user!.uid;

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
                Text('No workouts found. Create your first workout plan!'),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _selectedIndex = 1; // Navigate to Create Workout Screen
                  }),
                  child: Text('Create Workout'),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
