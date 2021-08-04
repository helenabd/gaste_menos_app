import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/api_path.dart';

abstract class Database {
  Future<void> createDesp(Desp desp);
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

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }
}
