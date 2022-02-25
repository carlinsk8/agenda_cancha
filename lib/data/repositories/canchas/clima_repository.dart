import 'dart:convert';

import 'package:agenda_cancha/domain/entities/response_clima.dart';
import 'package:http/http.dart' as http;

class ClimaRepository {
  final String key = 'e87a4d0db1ae41b6840191231222402';
  Future<ResponseClima> getClimaDay(String day) async {
    final url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$key&q=Lima&qt=$day");
    final response = await http.get(url);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      throw Exception(response.body);
    }
    final decodeData = json.decode(response.body);
    ResponseClima data = ResponseClima.fromMap(decodeData);
    return data;
  }
}
