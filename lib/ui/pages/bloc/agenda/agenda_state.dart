part of 'agenda_bloc.dart';

@immutable
abstract class AgendaState {
  final String? msjLimitAdd;
  final List<Agenda> listAgenta;

  const AgendaState({this.msjLimitAdd, required this.listAgenta});
}

class AgendaInitial extends AgendaState {
  AgendaInitial() : super(listAgenta: []);
}

class AgendaListSetState extends AgendaState {
  final List<Agenda> newAgentaList;

  const AgendaListSetState(this.newAgentaList)
      : super(listAgenta: newAgentaList);
}

class MsjErrorAddSetState extends AgendaState {
  final List<Agenda> newAgentaList;
  final String newMsjLimitAdd;

  const MsjErrorAddSetState(this.newAgentaList, this.newMsjLimitAdd)
      : super(listAgenta: newAgentaList, msjLimitAdd: newMsjLimitAdd);
}
