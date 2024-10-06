import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diente_admin/data/models/request.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
Future<List<RequestModel>> fetchAllRequests() async {
  List<RequestModel> requestsList = [];
  try {
    QuerySnapshot querySnapshot = await db.collection('requests').get();
    for (var doc in querySnapshot.docs) {
      requestsList
          .add(RequestModel.fromJson(doc.data() as Map<String, dynamic>));
    }
    log(requestsList.toString());
  } catch (e) {
    if (e is FirebaseException) {
      log("FirebaseException: ${e.message}");
    } else {
      log("Error fetching requests: $e");
    }
  }
  return requestsList;
}
