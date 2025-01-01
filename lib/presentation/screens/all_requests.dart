import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptedRequestsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> fetchAcceptedRequests() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('acceptedRequests').get();
      List<Map<String, dynamic>> requests = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'caseDescription':
              doc['caseDescription'] as Map<String, dynamic>? ?? {},
          'caseStatus': doc['caseStatus'] as String? ?? '',
        };
      }).toList();
      return requests;
    } catch (e) {
      print('Error fetching accepted requests: $e');
      return [];
    }
  }
}

class AcceptedRequestsScreen extends StatefulWidget {
  const AcceptedRequestsScreen({super.key});

  @override
  _AcceptedRequestsScreenState createState() => _AcceptedRequestsScreenState();
}

class _AcceptedRequestsScreenState extends State<AcceptedRequestsScreen> {
  List<Map<String, dynamic>> _acceptedRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAcceptedRequests();
  }

  Future<void> _loadAcceptedRequests() async {
    final acceptedRequestsService = AcceptedRequestsService();
    final requests = await acceptedRequestsService.fetchAcceptedRequests();
    setState(() {
      _acceptedRequests = requests;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Requests')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Tooth Number')),
                  DataColumn(label: Text('Case Status')),
                ],
                rows: _acceptedRequests.map((request) {
                  final caseDescription =
                      request['caseDescription'] as Map<String, dynamic>? ?? {};
                  return DataRow(cells: [
                    DataCell(SelectableText(request['id'] ?? '')),
                    DataCell(Text(caseDescription['Name'] ?? '')),
                    DataCell(Text(caseDescription['toothNumber'] ?? '')),
                    DataCell(Text(request['caseStatus'] ?? '')),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}
