part of 'form_agenda_bloc.dart';

@immutable
abstract class FormAgendaEvent {}

class SetDateAgenda extends FormAgendaEvent {
  final String newDate;

  SetDateAgenda(this.newDate);
}
