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
// Accept or reject a request

final CollectionReference requestsCollection =
    FirebaseFirestore.instance.collection('requests');
final CollectionReference acceptedRequestsCollection =
    FirebaseFirestore.instance.collection('acceptedRequests');

Future<void> acceptCase(RequestModel req) async {
  final String? id = req.id;
  if (id == null || id.isEmpty) {
    log('Invalid document ID');
    return;
  }

  try {
    await requestsCollection.doc(id).update({'isAccepted': true});
    log('Success');

    Map<String, dynamic> acceptedCase = {
      'patientId': id,
      'caseDescription': req.caseDescription,
      'caseStatus': 'Waiting'
    };

    await acceptedRequestsCollection.doc(id).set(acceptedCase);
    log("Case Added");
  } catch (error) {
    log("Failed to accept case: $error");
  }
}

Future<void> rejectCase(RequestModel req) async {
  final String? id = req.id;
  if (id == null || id.isEmpty) {
    log('Invalid document ID');
    return;
  }

  try {
    await requestsCollection.doc(id).update({'isAccepted': false});
    log('The case rejected successfully');
  } catch (error) {
    log('Failed: $error');
  }
}
