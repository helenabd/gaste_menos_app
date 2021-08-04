import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/api_path.dart';

abstract class Database {
  Future<void> createDesp(Desp desp);
  Stream<List<Desp>> despStream();
  Stream<List<T>> _collectionsStrem<T>(
      {@required String path,
      @required T Function(Map<String, dynamic> data) builder});
}

class FirestoreDatabase implements Database {
  final String uid;
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);

  Future<void> createDesp(Desp desp) => _setData(
        path: APIPath.desp(uid, 'desp_abc'),
        data: desp.toMap(),
      );

  Stream<List<Desp>> despStream() => _collectionsStrem(
      path: APIPath.despesas(uid), builder: (data) => Desp.fromMap(data));

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Stream<List<T>> _collectionsStrem<T>(
      {@required String path,
      @required T Function(Map<String, dynamic> data) builder}) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((snapshot) => builder(
              snapshot.data(),
            ))
        .toList());
  }
}
