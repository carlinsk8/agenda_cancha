part of 'form_agenda_bloc.dart';

@immutable
abstract class FormAgendaEvent {}

class DateInitial extends FormAgendaEvent {}

class SetDateAgenda extends FormAgendaEvent {
  final String? newDate;
  final String? newGrado;
  final String? newIcon;

  SetDateAgenda({
    this.newDate,
    this.newGrado,
    this.newIcon,
  });
}
