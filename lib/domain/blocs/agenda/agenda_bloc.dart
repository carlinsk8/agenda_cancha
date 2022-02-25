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
      final count = await _agendaRepository.getCanchaDay(
          event.agenda.date, event.agenda.name);
      if (count < 3) {
        emit(LoadingAgenda(state.listAgenta));
        //obteniendo clima
        final resp = await _agendaRepository.getDataClimaDay('2022-02-24');
        //Agragando temperatura y icon segun clima
        event.agenda.grado = '${resp.current.tempC}C°';
        event.agenda.icon = resp.current.condition.icon;
        //creando nueva agenda
        await _agendaRepository.newAgenda(event.agenda);

        add(GetAgendas());
        add(ChangeMsjErrorAgenda(null));
      } else {
        add(ChangeMsjErrorAgenda(
            'Esta cancha supero el limite de agenda por día.'));
      }
    });

    on<DeleteAgenda>((event, emit) async {
      await _agendaRepository.deleteAgenda(event.id);
      add(GetAgendas());
    });

    on<GetAgendas>((event, emit) async {
      final res = await _agendaRepository.getAllAgenda();
      if (res.isEmpty) {
        emit(AgendaInitial());
      } else {
        emit(AgendaListSetState(res));
      }
    });

    on<ChangeMsjErrorAgenda>((event, emit) {
      emit(MsjErrorAddSetState(
          newAgentaList: state.listAgenta, newMsjLimitAdd: event.msj));
    });
  }
}
