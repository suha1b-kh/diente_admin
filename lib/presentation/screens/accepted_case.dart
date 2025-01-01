import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptedCaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAcceptedCases() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('acceptedRequests').get();
      List<Map<String, dynamic>> cases = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'caseDescription': data['caseDescription'] ?? {},
          'caseStatus': data['caseStatus'] ?? '',
        };
      }).toList();
      return cases;
    } catch (e) {
      print('Error fetching accepted cases: $e');
      return [];
    }
  }
}

class AcceptedCaseScreen extends StatefulWidget {
  const AcceptedCaseScreen({super.key});

  @override
  _AcceptedCaseScreenState createState() => _AcceptedCaseScreenState();
}

class _AcceptedCaseScreenState extends State<AcceptedCaseScreen> {
  List<Map<String, dynamic>> _acceptedCases = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAcceptedCases();
  }

  Future<void> _loadAcceptedCases() async {
    final acceptedCaseService = AcceptedCaseService();
    final cases = await acceptedCaseService.fetchAcceptedCases();
    setState(() {
      _acceptedCases = cases;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accepted Cases')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _acceptedCases.isEmpty
              ? const Center(child: Text('No accepted cases found.'))
              : SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Tooth Number')),
                      DataColumn(label: Text('Case Status')),
                    ],
                    rows: _acceptedCases.where((caseData) {
                      return caseData['caseStatus'] == 'accepted';
                    }).map((caseData) {
                      final caseDescription =
                          caseData['caseDescription'] as Map<String, dynamic>;
                      return DataRow(cells: [
                        DataCell(SelectableText(caseData['id'] ?? '')),
                        DataCell(Text(caseDescription['Name'] ?? '')),
                        DataCell(Text(caseDescription['toothNumber'] ?? '')),
                        DataCell(Text(caseData['caseStatus'] ?? '')),
                      ]);
                    }).toList(),
                  ),
                ),
    );
  }
}
