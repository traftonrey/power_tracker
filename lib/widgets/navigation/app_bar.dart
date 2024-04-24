import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:power_tracker/screens/auth/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final user = FirebaseAuth.instance.currentUser;

  CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('BuiltBuddy', style: TextStyle(color: Color(0xe6f0e6ff))),
      backgroundColor: const Color(0xff6aa274),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons
              .account_circle), // This icon will be a user's profile picture
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountPage(
                      userId: user!.uid)), // Fix to handle null checks
            );
          },
          tooltip: 'Account Settings',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}