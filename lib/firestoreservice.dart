import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'weather.dart';

final CollectionReference myCollection =
    Firestore.instance.collection('weather');

class FirestoreService {
  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
