part of 'form_agenda_bloc.dart';

@immutable
abstract class FormAgendaState {
  final formKey = GlobalKey<FormState>();
  final String? date;
  final String? grado;
  final String? icon;
  final String? text;

  FormAgendaState({
    this.date,
    this.grado,
    this.icon,
    this.text,
  });
}

class FormAgendaInitial extends FormAgendaState {
  FormAgendaInitial() : super();
}

class DateSetState extends FormAgendaState {
  final String? newDate;
  final String? newGrado;
  final String? newIcon;
  final String? newText;
  DateSetState({
    this.newDate,
    this.newGrado,
    this.newIcon,
    this.newText,
  }) : super(date: newDate, grado: newGrado, icon: newIcon, text: newText);
}
