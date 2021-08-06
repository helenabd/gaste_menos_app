import 'package:flutter/material.dart';

class Ganho {
  final String id;
  final String categoria;
  final DateTime data;
  final String nome;
  final double valor;

  Ganho({
    @required this.id,
    @required this.categoria,
    @required this.data,
    @required this.nome,
    @required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoria': categoria,
      'data': data.millisecondsSinceEpoch,
      'nome': nome,
      'valor': valor,
    };
  }

  factory Ganho.fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) {
      return null;
    }
    return Ganho(
      id: documentId,
      categoria: map['categoria'],
      data: DateTime.fromMillisecondsSinceEpoch(map['data']),
      nome: map['nome'],
      valor: map['valor'],
    );
  }
}
