import 'package:agenda_cancha/domain/entities/agenda.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc() : super(AgendaInitial()) {
    on<AddAgenda>((event, emit) {
      int count = 0;
      for (var e in state.listAgenta) {
        if (event.agenda.name == e.name && event.agenda.date == e.date) {
          count = count + 1;
        }
      }
      if (count < 3) {
        state.listAgenta.add(event.agenda);
        emit(AgendaListSetState(state.listAgenta));
      } else {
        emit(MsjErrorAddSetState(state.listAgenta,
            'Esta cancha supero el limite de agenda por día'));
      }
    });
  }
}
