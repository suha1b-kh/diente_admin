import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diente_admin/data/models/problem.dart';

class ReportProblemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<ReportProblemModel>> fetchProblems() {
    return _firestore.collection('problems').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return ReportProblemModel.fromJson(data);
      }).toList();
    });
  }
}
