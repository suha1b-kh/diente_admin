import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WaitingRequestsScreen extends StatefulWidget {
  const WaitingRequestsScreen({super.key});

  @override
  _WaitingRequestsScreenState createState() => _WaitingRequestsScreenState();
}

class _WaitingRequestsScreenState extends State<WaitingRequestsScreen> {
  List<Map<String, dynamic>> _waitingRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWaitingRequests();
  }

  Future<void> _loadWaitingRequests() async {
    final waitingRequestsService = WaitingRequestsService();
    final requests = await waitingRequestsService.fetchWaitingRequests();
    setState(() {
      _waitingRequests = requests;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waiting Requests')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Tooth Number')),
                ],
                rows: _waitingRequests.map((request) {
                  final description =
                      request['description'] as Map<String, dynamic>? ?? {};
                  return DataRow(cells: [
                    DataCell(SelectableText(request['id'] ?? '')),
                    DataCell(Text(description['Name'] ?? '')),
                    DataCell(Text(description['toothNumber'] ?? '')),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}

class WaitingRequestsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchWaitingRequests() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('requests').get();
      List<Map<String, dynamic>> requests = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'description': doc['description'] as Map<String, dynamic>? ?? {},
        };
      }).toList();
      return requests;
    } catch (e) {
      print('Error fetching waiting requests: $e');
      return [];
    }
  }
}
