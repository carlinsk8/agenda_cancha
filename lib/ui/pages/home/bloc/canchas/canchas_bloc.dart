import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:agenda_cancha/domain/repositories/home/static_canchas_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'canchas_event.dart';
part 'canchas_state.dart';

class CanchasBloc extends Bloc<CanchasEvent, CanchasState> {
  CanchasBloc() : super(CanchasInitial()) {
    final canchasRepository = StaticCanchasRepository();
    on<GetCanchasList>((event, emit) async {
      final res = await canchasRepository.getDataCanchas();
      emit(CanchaListSetState(newListcancha: res));
    });
  }
}
