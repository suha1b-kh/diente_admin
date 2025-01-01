import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchPatients() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('patients').get();
      List<Map<String, dynamic>> patients = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
      return patients;
    } catch (e) {
      print('Error fetching patients: $e');
      return [];
    }
  }

  Future<void> removePatient(String id) async {
    try {
      await _firestore.collection('patients').doc(id).delete();
      // Assuming you have a FirebaseAuth instance and user management setup
      // You need to delete the user from Firebase Authentication as well
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(id);
      if (signInMethods.isNotEmpty) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && user.email == id) {
          await user.delete();
        }
      }
    } catch (e) {
      print('Error removing patient: $e');
    }
  }
}

class MyPatientsScreen extends StatefulWidget {
  const MyPatientsScreen({super.key});

  @override
  _MyPatientsScreenState createState() => _MyPatientsScreenState();
}

class _MyPatientsScreenState extends State<MyPatientsScreen> {
  List<Map<String, dynamic>> _patients = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    final patientService = PatientService();
    final patients = await patientService.fetchPatients();
    setState(() {
      _patients = patients
        ..sort((a, b) => (a['email'] ?? '').compareTo(b['email'] ?? ''));
      _isLoading = false;
    });
  }

  void _deletePatient(String id) async {
    final patientService = PatientService();
    await patientService.removePatient(id);
    _loadPatients(); // Refresh the patient list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Medical History')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _patients.map((patient) {
                  return DataRow(cells: [
                    DataCell(SelectableText(patient['id'] ?? '')),
                    DataCell(Text(
                        patient['firstName'] + ' ' + patient['secondName'] ??
                            '')),
                    DataCell(Text(patient['age']?.toString() ?? '')),
                    DataCell(Text(patient['email'] ?? '')),
                    DataCell(Text(patient['phoneNumber'] ?? '')),
                    DataCell(Text(
                        _getTrueMedicalHistory(patient['medicalHistory']))),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePatient(patient['id']),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
    );
  }

  String _getTrueMedicalHistory(Map<String, dynamic>? medicalHistory) {
    if (medicalHistory == null || medicalHistory.isEmpty) {
      return 'No Medical History';
    }
    List<String> trueConditions = [];
    medicalHistory.forEach((key, value) {
      if (value is bool && value) {
        trueConditions.add(key);
      }
    });
    return trueConditions.isNotEmpty
        ? trueConditions.join(', ')
        : 'No Medical History';
  }
}
