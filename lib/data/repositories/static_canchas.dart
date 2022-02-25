import 'dart:convert';
import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:flutter/services.dart';

class StaticCanchas {
  Future<List<Cancha>> getCanchas() async {
    final String res = await rootBundle.loadString('assets/data_canchas.json');
    List<dynamic> _currencys = jsonDecode(res);

    return _currencys.map((e) => Cancha.fromMap(e)).toList();
  }
}
