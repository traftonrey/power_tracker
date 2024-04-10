import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'auth/sign_in_screen.dart';
import 'auth/sign_up_screen.dart';

class SplashScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Powerlifting Tracker',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToSignIn(context),
              child: Text('Sign In with Email'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToSignUp(context),
              child: Text('Sign Up with Email'),
            ),
            // Placeholder for Google Sign-In
            ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SignInScreen())); // Update with your sign-in screen widget
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SignUpScreen())); // Update with your sign-up screen widget
  }

  void _signInWithGoogle(BuildContext context) {
    // Implement Google sign-in logic
    print('Google Sign-In will be implemented here');
  }
}
