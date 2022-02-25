import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '/domain/repositories/agenda_repository.dart';

part 'form_agenda_event.dart';
part 'form_agenda_state.dart';

final _agendaRepository = AgendaRepository();

class FormAgendaBloc extends Bloc<FormAgendaEvent, FormAgendaState> {
  FormAgendaBloc() : super(FormAgendaInitial()) {
    on<SetDateAgenda>((event, emit) async {
      //obteniendo clima
      final resp = await _agendaRepository.getDataClimaDay('${event.newDate}');

      emit(DateSetState(
        newDate: event.newDate,
        newGrado: '${resp.current.tempC}C°',
        newIcon: 'https:${resp.current.condition.icon}',
        newText: resp.current.condition.text,
      ));
    });
    on<DateInitial>((event, emit) async {
      emit(FormAgendaInitial());
    });
  }
}
