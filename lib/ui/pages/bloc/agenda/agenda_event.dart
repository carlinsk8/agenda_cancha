part of 'agenda_bloc.dart';

@immutable
abstract class AgendaEvent {}

class AddAgenda extends AgendaEvent {
  final Agenda agenda;

  AddAgenda(this.agenda);
}

class MsjErrorAgenda extends AgendaEvent {
  final String msj;

  MsjErrorAgenda(this.msj);
}
