

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreService {
  final CollectionReference _serviceCollactionRef =
  FirebaseFirestore.instance.collection('Store');
  Future<List<QueryDocumentSnapshot>> getStore() async {
    var value = await _serviceCollactionRef.get();
    return value.docs;
  }
}