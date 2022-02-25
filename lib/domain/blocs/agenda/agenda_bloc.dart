import 'package:agenda_cancha/domain/entities/agenda.dart';
import 'package:agenda_cancha/domain/repositories/agenda_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

final _agendaRepository = AgendaRepository();

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial()) {
    on<AddAgenda>((event, emit) async {
      final res = await _agendaRepository.getCanchaDay(
          event.agenda.date, event.agenda.name);
      int count = res[0]['count(*)'];
      if (count <= 3) {
        emit(LoadingAgenda(state.listAgenta));
        //obteniendo clima
        final resp = await _agendaRepository.getDataClimaDay('2022-02-24');

        event.agenda.grado = '${resp.current.tempC}C°';
        event.agenda.icon = resp.current.condition.icon;
        state.listAgenta.add(event.agenda);
        //Ordenando por fecha
        state.listAgenta.sort((a, b) {
          var adate = a.date;
          var bdate = b.date;
          return -bdate.compareTo(adate);
        });
        await _agendaRepository.newAgenda(event.agenda);
        emit(AgendaListSetState(state.listAgenta));

        add(GetAgendas());
        add(ChangeMsjErrorAgenda(null));
      } else {
        add(ChangeMsjErrorAgenda(
            'Esta cancha supero el limite de agenda por día'));
      }
    });
    on<DeleteAgenda>((event, emit) async {
      await _agendaRepository.deleteAgenda(event.id);
      add(GetAgendas());
    });
    on<GetAgendas>((event, emit) async {
      final res = await _agendaRepository.getAllAgenda();
      emit(AgendaListSetState(res));
    });

    on<ChangeMsjErrorAgenda>((event, emit) {
      emit(MsjErrorAddSetState(
          newAgentaList: state.listAgenta, newMsjLimitAdd: event.msj));
    });
  }
}
