import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyStudentsScreen extends StatefulWidget {
  const MyStudentsScreen({super.key});

  @override
  _MyStudentsScreenState createState() => _MyStudentsScreenState();
}

class _MyStudentsScreenState extends State<MyStudentsScreen> {
  List<Map<String, dynamic>> _students = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final studentService = StudentService();
    final students = await studentService.fetchStudents();
    setState(() {
      _students = students;
      _isLoading = false;
    });
  }

  void _deleteStudent(String id) async {
    final studentService = StudentService();
    await studentService.removeStudent(id);
    _loadStudents(); // Refresh the student list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Year')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _students.map((student) {
                  return DataRow(cells: [
                    DataCell(SelectableText(student['id'] ?? '')),
                    DataCell(Text(student['name'] ?? '')),
                    DataCell(Text(student['email'] ?? '')),
                    DataCell(Text(student['phone'] ?? '')),
                    DataCell(Text(student['year']?.toString() ?? '')),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStudent(student['id']),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchStudents() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('students').get();
      List<Map<String, dynamic>> students = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
      return students;
    } catch (e) {
      print('Error fetching students: $e');
      return [];
    }
  }

  Future<void> removeStudent(String id) async {
    try {
      await _firestore.collection('students').doc(id).delete();
    } catch (e) {
      print('Error removing student: $e');
    }
  }
}
