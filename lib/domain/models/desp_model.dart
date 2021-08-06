import 'package:flutter/foundation.dart';

class Desp {
  Desp({
    @required this.id,
    @required this.categoria,
    @required this.data,
    @required this.nome,
    @required this.valor,
  });

  final String id;
  final String categoria;
  final DateTime data;
  final String nome;
  final double valor;

  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'data': data.millisecondsSinceEpoch,
      'nome': nome,
      'valor': valor,
    };
  }

  factory Desp.fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) {
      return null;
    }
    return Desp(
      id: documentId,
      categoria: map['categoria'],
      data: DateTime.fromMillisecondsSinceEpoch(map['data']),
      nome: map['nome'],
      valor: map['valor'],
    );
  }
}
