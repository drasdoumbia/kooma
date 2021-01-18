import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kooma/models/message_model.dart';

class FirebaseService {
  FirebaseService._();
  static final instance = FirebaseService._();

  final _fireStore = FirebaseFirestore.instance;

  Future<void> createMessage(
      {@required String path, Map<String, dynamic> data}) async {
    final reference = _fireStore.collection(path);
    await reference.add(data).catchError((error) => print(error));
  }

  Future<void> updateData({
    @required String path,
    @required String id,
    @required Map<String, dynamic> data,
  }) async {
    final reference = _fireStore.collection(path).doc(id);
    print('$path: $data, $id: $id');
    await reference.update(data).catchError((error) => print(error));
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = _fireStore.collection(path).orderBy('time', descending: true);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs.reversed
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = _fireStore.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }
}
