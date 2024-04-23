import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/user_service.dart';
import '../../services/auth_service.dart';
import '../../widgets/height_picker.dart';
import '../../screens/splash_screen.dart';

class AccountPage extends StatefulWidget {
  final String userId;

  const AccountPage({super.key, required this.userId});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 0; // For bottom navigation bar
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  // Text Editing Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // Non-editable and nullable fields
  String? _email;
  String? _sex;
  DateTime? _dob;
  double? _height;
  String? _preferredUnitOfMeasurement;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      var userData = await _userService.getUserData(widget.userId);
      if (userData.isNotEmpty) {
        setState(() {
          _email = userData['email'];
          _firstNameController.text = userData['firstName'] ?? '';
          _lastNameController.text = userData['lastName'] ?? '';
          _phoneNumberController.text = userData['phoneNumber'] ?? '';
          _weightController.text = userData['weight']?.toString() ?? '';
          _sex = userData['sex'];
          _dob =
              userData['dob'] != null ? DateTime.parse(userData['dob']) : null;
          _dobController.text =
              _dob != null ? "${_dob!.year}-${_dob!.month}-${_dob!.day}" : '';
          _height = userData['height']?.toDouble();
          _preferredUnitOfMeasurement = userData['preferredUnitOfMeasurement'];
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _updateUserProfile() async {
    if (!_formKey.currentState!.validate()) return;
    Map<String, dynamic> updates = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'weight': double.tryParse(_weightController.text),
      'sex': _sex,
      'dob': _dob?.toIso8601String(),
      'height': _height,
      'preferredUnitOfMeasurement': _preferredUnitOfMeasurement,
    };
    bool success = await _userService.updateUserProfile(
        userId: widget.userId, updates: updates);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile.')));
    }
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () =>
                  Navigator.of(context).pop(), // Dismiss the dialog
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Dismiss the dialog before deleting
                _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount() async {
    bool success = await _userService.deleteUserData(widget.userId) &&
        await _authService.deleteUser();

    if (!mounted) return;

    if (success) {
      // Assumed logout and navigation to splash screen
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => SplashScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete account.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _openDrawer,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildAccountForm(),
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

  void _openDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  Widget buildAccountForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ListTile(
              title: const Text("Email"),
              subtitle: Text(_email ?? 'Loading...'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your first name' : null,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your last name' : null,
            ),
            TextFormField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon:
                    Icon(Icons.calendar_today), // Optional icon for visual hint
              ),
              readOnly: true, // Prevents keyboard from appearing
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dob ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _dob) {
                  setState(() {
                    _dob = picked;
                    _dobController.text = DateFormat('yyyy-MM-dd')
                        .format(picked); // Formatting the date
                  });
                }
              },
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text(_preferredUnitOfMeasurement == "Metric"
                  ? 'Unit of Measurement: Metric'
                  : 'Unit of Measurement: Imperial'),
              value: _preferredUnitOfMeasurement == "Metric" ? true : false,
              onChanged: (bool value) {
                setState(() {
                  if (value) {
                    _preferredUnitOfMeasurement = "Metric";
                  } else {
                    _preferredUnitOfMeasurement = "Imperial";
                  }
                });
              },
            ),
            HeightPicker(
              heightInCentimeters: _height ?? 0.0,
              isMetric: _preferredUnitOfMeasurement == "Metric",
              onChanged: (newHeight) {
                setState(() {
                  _height = newHeight;
                });
              },
            ),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: const Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: _confirmDeleteAccount,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
