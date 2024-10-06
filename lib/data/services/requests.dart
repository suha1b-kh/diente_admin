import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diente_admin/data/models/request.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<RequestModel>> fetchAllRequests() async {
  List<RequestModel> studentsList = [];
  try {
    QuerySnapshot querySnapshot = await db.collection('requests').get();
    for (var doc in querySnapshot.docs) {
      studentsList
          .add(RequestModel.fromJson(doc.data() as Map<String, dynamic>));
    }
    log(studentsList.toString());
  } catch (e) {
    log("Error fetching students: $e");
  }
  return studentsList;
}
