import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'form_agenda_event.dart';
part 'form_agenda_state.dart';

class FormAgendaBloc extends Bloc<FormAgendaEvent, FormAgendaState> {
  FormAgendaBloc() : super(FormAgendaInitial()) {
    on<SetDateAgenda>((event, emit) {
      emit(DateSetState(event.newDate));
    });
  }
}
