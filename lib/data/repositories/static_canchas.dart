import 'dart:convert';
import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:flutter/services.dart';

class StaticCanchas {
  Future<List<Cancha>> getCanchas() async {
    List _currencys =
        jsonDecode(await rootBundle.loadString('assets/data_canchas.json'));

    return _currencys.map((e) => Cancha.fromMap(e)).toList();
  }
}
