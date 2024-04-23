import 'package:flutter/material.dart';
import 'auth/sign_in_screen.dart';
import 'auth/sign_up_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to Powerlifting Tracker',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToSignIn(context),
              child: const Text('Sign In with Email'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToSignUp(context),
              child: const Text('Sign Up with Email'),
            ),
            // Placeholder for Google Sign-In
            ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: const Text('Sign In with Google'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => _skipToHome(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
                child: const Text('Skip to Home')),
          ],
        ),
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const SignInScreen())); // Update with your sign-in screen widget
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const SignUpScreen())); // Update with your sign-up screen widget
  }

  void _signInWithGoogle(BuildContext context) {
    // Implement Google sign-in logic
    print('Google Sign-In will be implemented here');
  }

  void _skipToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            const HomeScreen())); // Navigate to the Home Screen
  }
}
