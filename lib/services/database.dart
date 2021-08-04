import 'package:flutter/foundation.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/api_path.dart';
import 'package:gaste_menos_app/services/services.dart';

abstract class Database {
  Future<void> createDesp(Desp desp);
  Stream<List<Desp>> despStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);

  Future<void> createDesp(Desp desp) => _service.setData(
        path: APIPath.desp(uid, 'desp_abc'),
        data: desp.toMap(),
      );

  Stream<List<Desp>> despStream() => _service.collectionsStrem(
      path: APIPath.despesas(uid), builder: (data) => Desp.fromMap(data));
}
