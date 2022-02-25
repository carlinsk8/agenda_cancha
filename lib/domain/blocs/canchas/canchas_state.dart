part of 'canchas_bloc.dart';

@immutable
abstract class CanchasState {
  final List<Cancha>? listCancha;

  const CanchasState({this.listCancha});
}

class CanchasInitial extends CanchasState {
  CanchasInitial() : super(listCancha: []);
}

class CanchaListSetState extends CanchasState {
  final List<Cancha> newListcancha;

  const CanchaListSetState({
    required this.newListcancha,
  }) : super(
          listCancha: newListcancha,
        );
}
