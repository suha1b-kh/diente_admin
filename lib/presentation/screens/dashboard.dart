import 'dart:developer';
import 'package:diente_admin/data/services/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
  int? _problemsCount;
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
        DashboardServices().getProblemsCount(),
        DashboardServices().getPatientsCount(),
        DashboardServices().countCasesByStatus('active'),
        DashboardServices().countCasesByStatus('accepted'),
      ]);

      _studentsCount = results[0] as int?;
      _acceptedRequestsCount = results[1] as int?;
      _problemsCount = results[2] as int?;
      _patientsCount = results[3] as int?;
      _activeCasesCount = results[4] as int?;
      _acceptedCasesCount = results[5] as int?;
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
                  : BarChart(
                      BarChartData(
                        barGroups: [
                          _buildBarChartGroup('Students', _studentsCount),
                          _buildBarChartGroup(
                              'Accepted Requests', _acceptedRequestsCount),
                          _buildBarChartGroup('Problems', _problemsCount),
                          _buildBarChartGroup('Patients', _patientsCount),
                          _buildBarChartGroup(
                              'Active Cases', _activeCasesCount),
                          _buildBarChartGroup(
                              'Accepted Cases', _acceptedCasesCount),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        barTouchData: BarTouchData(enabled: false),
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

  BarChartGroupData _buildBarChartGroup(String title, int? value) {
    return BarChartGroupData(
      x: title.hashCode, // Unique identifier for each bar
      barRods: [
        BarChartRodData(
          toY: value?.toDouble() ?? 0,
          color: Colors.blue,
        ),
      ],
    );
  }
}
