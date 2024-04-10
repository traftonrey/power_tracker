import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _trySignIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    // Use your AuthService to sign in
    final user =
        await AuthService().signInWithEmailAndPassword(_email, _password);
    if (user != null) {
      // Navigate to your home screen
    } else {
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSaved: (value) => _password = value!,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
            ),
            ElevatedButton(
              onPressed: _trySignIn,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
