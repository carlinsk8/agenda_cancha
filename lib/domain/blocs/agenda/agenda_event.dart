part of 'agenda_bloc.dart';

@immutable
abstract class AgendaEvent {}

class AddAgenda extends AgendaEvent {
  final Agenda agenda;

  AddAgenda(this.agenda);
}

class ChangeMsjErrorAgenda extends AgendaEvent {
  final String? msj;

  ChangeMsjErrorAgenda(this.msj);
}

class GetAgendas extends AgendaEvent {}

class DeleteAgenda extends AgendaEvent {
  final int? id;

  DeleteAgenda(this.id);
}
