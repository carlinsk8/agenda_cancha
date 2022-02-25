import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:agenda_cancha/domain/repositories/agenda_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'canchas_event.dart';
part 'canchas_state.dart';

final _agendaRepository = AgendaRepository();

class CanchasBloc extends Bloc<CanchasEvent, CanchasState> {
  CanchasBloc() : super(CanchasInitial()) {
    on<GetCanchasList>((event, emit) async {
      final res = await _agendaRepository.getDataCanchas();
      emit(CanchaListSetState(newListcancha: res));
    });
  }
}
