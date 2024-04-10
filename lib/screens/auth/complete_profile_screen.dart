import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../home_screen.dart';
import '../../widgets/height_picker.dart'; // Make sure this import path is correct

class CompleteProfileScreen extends StatefulWidget {
  final String userId;

  const CompleteProfileScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  String? _sex;
  DateTime? _dob;
  final TextEditingController _dobController = TextEditingController();
  double? _weight;
  double _heightInCentimeters = 152.4; // Default to 5'0" in cm
  bool _isMetric = false; // Default to Imperial

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  void _tryCompleteProfile() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    Map<String, dynamic> updates = {
      if (_sex != null) 'sex': _sex,
      if (_dob != null) 'dob': _dob!.toIso8601String(),
      if (_weight != null) 'weight': _weight,
      'height': _heightInCentimeters, // Save height in centimeters
      'preferredUnitOfMeasurement': _isMetric ? 'Metric' : 'Imperial',
    };

    bool success = await _userService.updateUserProfile(
        userId: widget.userId, updates: updates);

    if (!mounted) return;

    if (success) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile update failed. Try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sex'),
                value: _sex,
                onChanged: (value) => setState(() => _sex = value),
                items: ['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select an option' : null,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _dob ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (picked != null && picked != _dob) {
                    setState(() {
                      _dob = picked;
                      _dobController.text =
                          "${picked.year}-${picked.month}-${picked.day}";
                    });
                  }
                },
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your date of birth' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => _weight = double.tryParse(value!),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your weight' : null,
              ),
              SwitchListTile(
                title: Text(_isMetric ? 'Metric' : 'Imperial'),
                value: _isMetric,
                onChanged: (bool value) {
                  setState(() {
                    _isMetric = value;
                  });
                },
              ),
              HeightPicker(
                heightInCentimeters: _heightInCentimeters,
                isMetric: _isMetric,
                onChanged: (newHeight) {
                  _heightInCentimeters = newHeight;
                },
              ),
              ElevatedButton(
                onPressed: _tryCompleteProfile,
                child: const Text('Complete Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
