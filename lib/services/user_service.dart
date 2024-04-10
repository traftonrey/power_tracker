import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;

  // Method to create a new user profile in Firestore
  Future<bool> createUserProfile({
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    String? phoneNumber,
  }) async {
    try {
      // Construct a map with user data
      Map<String, dynamic> userData = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'accountCreationDate': DateTime.now(),
        'lastSignInDate': DateTime.now(),
        // Default values for the new fields
        'sex': null,
        'dob': null,
        'weight': null,
        'height': null,
        'preferredUnitOfMeasurement': 'Imperial', // Default to Imperial
      };

      // Add the user data to Firestore
      await _firestore.collection('users').doc(userId).set(userData);

      // Return true to indicate successful user profile creation
      return true;
    } catch (error) {
      // Handle any errors that occur during the Firestore write operation
      print('Error creating user profile: $error');
      return false;
    }
  }

  // Method to fetch user data from Firestore
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.data() ?? {};
      } else {
        return {}; // Return an empty map if user data doesn't exist
      }
    } catch (error) {
      // Handle any errors that occur during the Firestore read operation
      print('Error fetching user data: $error');
      rethrow; // Rethrow the error to handle it in the calling code
    }
  }

  // Method to update existing user profile details
  Future<bool> updateUserProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
      return true;
    } catch (e) {
      print("Error updating user profile: $e");
      return false;
    }
  }

  // Method to delete user data from Firestore
  Future<bool> deleteUserData(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      return true; // Return true if deletion is successful
    } catch (error) {
      // Handle any errors that occur during the Firestore delete operation
      print('Error deleting user data: $error');
      return false; // Return false if deletion fails
    }
  }
}
