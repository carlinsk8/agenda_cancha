import 'package:agenda_cancha/data/repositories/canchas/clima_repository.dart';
import 'package:agenda_cancha/data/repositories/static_canchas.dart';
import 'package:agenda_cancha/data/services/db_service.dart';
import 'package:agenda_cancha/domain/entities/agenda.dart';
import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:agenda_cancha/domain/entities/response_clima.dart';

class AgendaRepository {
  final staticCanchasService = StaticCanchas();
  final climaService = ClimaRepository();

  Future<List<Cancha>> getDataCanchas() => staticCanchasService.getCanchas();

  Future<ResponseClima> getDataClimaDay(String day) =>
      climaService.getClimaDay(day);

  Future<int> newAgenda(Agenda newAgenda) => DBService.db.newAgenda(newAgenda);
  Future<List<Agenda>> getAllAgenda() => DBService.db.getAllAgenda();
  Future<int> deleteAgenda(int? id) => DBService.db.deleteAgenda(id);
  Future<List> getCanchaDay(String date, String name) =>
      DBService.db.getCanchaDay(date, name);
}
