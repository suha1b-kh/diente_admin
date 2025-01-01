import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get the count of documents in the `acceptedRequests` collection
  Future<int> getAcceptedRequestsCount() async {
    try {
      final querySnapshot =
          await _firestore.collection('acceptedRequests').get();
      return querySnapshot.docs.length;
    } catch (e) {
      print('Error fetching acceptedRequests count: $e');
      return 0;
    }
  }

  /// Get the count of documents in the `students` collection
  Future<int> getStudentsCount() async {
    try {
      final querySnapshot = await _firestore.collection('students').get();
      return querySnapshot.docs.length;
    } catch (e) {
      print('Error fetching students count: $e');
      return 0;
    }
  }

  /// Get the count of documents in the `patients` collection
  Future<int> getPatientsCount() async {
    try {
      final querySnapshot = await _firestore.collection('patients').get();
      return querySnapshot.docs.length;
    } catch (e) {
      print('Error fetching patients count: $e');
      return 0;
    }
  }

  /// Get the count of documents in the `problems` collection
  Future<int> getProblemsCount() async {
    try {
      final querySnapshot = await _firestore.collection('problems').get();
      return querySnapshot.docs.length;
    } catch (e) {
      print('Error fetching problems count: $e');
      return 0;
    }
  }

  /// Count the number of cases by status
  Future<int> countCasesByStatus(String status) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('acceptedRequests')
        .where('caseStatus', isEqualTo: status)
        .get();
    return querySnapshot.docs.length;
  }

  /// Count the number of cases by type
  // Future<Map<String, int>> countCasesByType() async {
  //   final querySnapshot =
  //       await FirebaseFirestore.instance.collection('acceptedRequests').get();
  //   Map<String, int> caseCounts = {};
  //   for (var doc in querySnapshot.docs) {
  //     String caseName = doc['caseDescription']['Name'];
  //     caseCounts[caseName] = (caseCounts[caseName] ?? 0) + 1;
  //   }
  //   return caseCounts;
  // }

  /// Get the student ID by email
  Future<String?> getPatientIdByEmail(String email) async {
    try {
      CollectionReference patients =
          FirebaseFirestore.instance.collection('patients');
      QuerySnapshot querySnapshot =
          await patients.where('email', isEqualTo: email).get();
      // log(querySnapshot.docs.toString());
      if (querySnapshot.docs.isNotEmpty) {
        // log('querySnapshot.docs.toString()');

        return querySnapshot.docs.first.id;
      }
      return 'No patient found with email $email';
    } catch (e) {
      print("Error retrieving patient ID: $e");
      return null;
    }
  }

  Future<int?> getRequestsCount() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('requests').get();
      return snapshot.docs.length; // Return the count of documents
    } catch (e) {
      print('Error fetching requests count: $e');
      return null;
    }
  }

  /// Get the student ID by email
  Future<String?> getStudentIdByEmail(String email) async {
    try {
      CollectionReference students =
          FirebaseFirestore.instance.collection('students');
      QuerySnapshot querySnapshot =
          await students.where('email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      return 'No student found with email $email';
    } catch (e) {
      print("Error retrieving student ID: $e");
      return null;
    }
  }
}
