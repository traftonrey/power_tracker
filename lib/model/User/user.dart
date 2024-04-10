import 'user_role.dart';

class User {
  String
      id; // Unique identifier for the user, typically the UID from FirebaseAuth
  String firstName;
  String lastName;
  String email;
  UserRole role;
  String? phoneNumber;
  String? sex; // Changed from 'gender' to 'sex'
  DateTime? dob; // Date of Birth
  double? weight;
  double? height;
  String preferredUnitOfMeasurement; // e.g., "Metric" or "Imperial"
  DateTime accountCreationDate; // Date of account creation
  DateTime lastSignInDate; // Date/time of the most recent sign-in

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role = UserRole.defaultUser, // Default role
    this.phoneNumber,
    this.sex,
    this.dob,
    this.weight,
    this.height,
    this.preferredUnitOfMeasurement = "Imperial", // Default unit
    required this.accountCreationDate,
    required this.lastSignInDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role.toString().split('.').last, // Convert enum to string
      'phoneNumber': phoneNumber,
      'sex': sex,
      'dob': dob?.toIso8601String(), // Convert DateTime to ISO string
      'weight': weight,
      'height': height,
      'preferredUnitOfMeasurement': preferredUnitOfMeasurement,
      'accountCreationDate': accountCreationDate.toIso8601String(),
      'lastSignInDate': lastSignInDate.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      role: UserRole.values.firstWhere(
          (e) => e.toString() == 'UserRole.${map['role']}',
          orElse: () => UserRole.defaultUser),
      phoneNumber: map['phoneNumber'],
      sex: map['sex'],
      dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
      weight: map['weight']?.toDouble(),
      height: map['height']?.toDouble(),
      preferredUnitOfMeasurement: map['preferredUnitOfMeasurement'] ?? "Metric",
      accountCreationDate: DateTime.parse(map['accountCreationDate']),
      lastSignInDate: DateTime.parse(map['lastSignInDate']),
    );
  }
}
