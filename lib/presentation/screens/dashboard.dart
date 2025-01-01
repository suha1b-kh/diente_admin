import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diente_admin/data/services/dashboard.dart';
import 'package:diente_admin/presentation/screens/accepted_case.dart';
import 'package:diente_admin/presentation/screens/all_requests.dart';
import 'package:diente_admin/presentation/screens/active_case.dart';
import 'package:diente_admin/presentation/screens/patient_screen.dart';
import 'package:diente_admin/presentation/screens/student_screen.dart';
import 'package:diente_admin/presentation/screens/waiting_requests.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userType = 'student';
  String? _userId;
  final TextEditingController _emailController = TextEditingController();

  int? _studentsCount;
  int? _acceptedRequestsCount;
  int? _requestsCount; // New variable for requests count
  int? _patientsCount;
  int? _activeCasesCount;
  int? _acceptedCasesCount;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      final results = await Future.wait([
        DashboardServices().getStudentsCount(),
        DashboardServices().getAcceptedRequestsCount(),
        DashboardServices().getRequestsCount(), // Fetch requests count
        DashboardServices().getPatientsCount(),
        DashboardServices().countCasesByStatus('active'),
        DashboardServices().countCasesByStatus('accepted'),
      ]);

      _studentsCount = results[0];
      _acceptedRequestsCount = results[1];
      _requestsCount = results[2];
      _patientsCount = results[3];
      _activeCasesCount = results[4];
      _acceptedCasesCount = results[5];
    } catch (e) {
      log('Error loading dashboard data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Overview'),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 50,
                        childAspectRatio: 3.5,
                        shrinkWrap: true,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyStudentsScreen()),
                              );
                            },
                            child: _buildDashboardCard(
                                'Students', _studentsCount.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AcceptedRequestsScreen()),
                              );
                            },
                            child: _buildDashboardCard(
                                'All Cases', _acceptedRequestsCount.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WaitingRequestsScreen()),
                              );
                            },
                            child: _buildDashboardCard(
                                'Waiting Requests', _requestsCount.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyPatientsScreen()),
                              );
                            },
                            child: _buildDashboardCard(
                                'Patients', _patientsCount.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ActiveCaseScreen()),
                              );
                            },
                            child: _buildDashboardCard(
                                'Active Cases', _activeCasesCount.toString()),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AcceptedCaseScreen()),
                              );
                            },
                            child: _buildDashboardCard('Accepted Cases',
                                _acceptedCasesCount.toString()),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 350),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 350),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Student'),
                      leading: Radio<String>(
                        value: 'student',
                        groupValue: _userType,
                        onChanged: (value) {
                          setState(() {
                            _userType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Patient'),
                      leading: Radio<String>(
                        value: 'patient',
                        groupValue: _userType,
                        onChanged: (value) {
                          setState(() {
                            _userType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 350),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String userId;
                      if (_userType == 'student') {
                        userId = await DashboardServices()
                                .getStudentIdByEmail(email) ??
                            'No ID found';
                      } else {
                        userId = await DashboardServices()
                                .getPatientIdByEmail(email) ??
                            'No ID found';
                      }
                      setState(() {
                        _userId = userId;
                      });

                      log('User ID: $_userId');
                      log('User Type: $_userType');
                    },
                    child: const Text('Get ID'),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    _userId ?? 'No ID found',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
