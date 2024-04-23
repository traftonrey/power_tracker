import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _errorMessage; // Optional: To display any error messages

  void _trySignIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    // Clear previous error messages
    setState(() {
      _errorMessage = null;
    });

    // Use your AuthService to sign in
    final user =
        await AuthService().signInWithEmailAndPassword(_email, _password);
    if (user != null) {
      // Navigate to your home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show error message
      setState(() {
        _errorMessage =
            "Failed to sign in. Please check your email and password.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value!,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter your email';
                // Optional: Add more complex validation for email
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSaved: (value) => _password = value!,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter your password';
                return null;
              },
            ),
            if (_errorMessage != null) // Display error message if there is one
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              ),
            ElevatedButton(
              onPressed: _trySignIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
