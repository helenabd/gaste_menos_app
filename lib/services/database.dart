import 'package:flutter/foundation.dart';

import 'package:gaste_menos_app/domain/domain.dart';
import 'package:gaste_menos_app/services/api_path.dart';
import 'package:gaste_menos_app/services/services.dart';

abstract class Database {
  Future<void> setDesp(Desp desp);
  Stream<List<Desp>> despStream();
  Future<void> deleteDesp(Desp desp);
  Future<void> setGanho(Ganho ganho);
  Stream<List<Ganho>> ganhoStream();
  Future<void> deleteGanho(Ganho ganho);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);

  @override
  Future<void> setDesp(Desp desp) => _service.setData(
        path: APIPath.desp(uid, desp.id),
        data: desp.toMap(),
      );

  @override
  Stream<List<Desp>> despStream() => _service.collectionsStrem(
      path: APIPath.despesas(uid),
      builder: (data, documentId) => Desp.fromMap(data, documentId));

  @override
  Future<void> deleteDesp(Desp desp) =>
      _service.deleteData(path: APIPath.desp(uid, desp.id));

  @override
  Future<void> setGanho(Ganho ganho) => _service.setData(
        path: APIPath.ganho(uid, ganho.id),
        data: ganho.toMap(),
      );

  @override
  Stream<List<Ganho>> ganhoStream() => _service.collectionsStrem(
        path: APIPath.ganhos(uid),
        builder: (data, documentId) => Ganho.fromMap(data, documentId),
      );

  @override
  Future<void> deleteGanho(Ganho ganho) =>
      _service.deleteData(path: APIPath.ganho(uid, ganho.id));
}
