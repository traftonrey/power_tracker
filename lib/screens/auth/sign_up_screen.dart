import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import 'complete_profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  String _email = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String? _phoneNumber;

  void _trySignUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final user =
        await _authService.signUpWithEmailAndPassword(_email, _password);
    if (!mounted) return;

    if (user != null) {
      // Assuming successful sign-up, create user profile
      await _userService.createUserProfile(
        userId: user.uid,
        email: _email,
        firstName: _firstName,
        lastName: _lastName,
        phoneNumber: _phoneNumber,
      );
      if (!mounted) return;
      // Then navigate to CompleteProfileScreen or directly to HomeScreen if you prefer
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => CompleteProfileScreen(userId: user.uid)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign up. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(labelText: 'First Name'),
                  onSaved: (value) => _firstName = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your first name' : null),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  onSaved: (value) => _lastName = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your last name' : null),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _email = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your email' : null),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) => _password = value!,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a password' : null),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Phone Number (Optional)'),
                  onSaved: (value) => _phoneNumber = value),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _trySignUp, child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
