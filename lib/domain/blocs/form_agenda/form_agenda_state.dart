part of 'form_agenda_bloc.dart';

@immutable
abstract class FormAgendaState {
  final formKey = GlobalKey<FormState>();
  final String? date;

  FormAgendaState({this.date});
}

class FormAgendaInitial extends FormAgendaState {
  FormAgendaInitial() : super(date: '');
}

class DateSetState extends FormAgendaState {
  final String newDate;
  DateSetState(this.newDate) : super(date: newDate);
}
