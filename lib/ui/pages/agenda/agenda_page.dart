import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/blocs/form_agenda/form_agenda_bloc.dart';
import '/domain/entities/cancha.dart';
import 'widgets/card_image_hero.dart';
import 'widgets/form_agenda.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  void initState() {
    BlocProvider.of<FormAgendaBloc>(context).add(DateInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Cancha cancha = ModalRoute.of(context)!.settings.arguments as Cancha;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cancha de tenis'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardImageHero(cancha: cancha),
            FormReserva(cancha: cancha),
          ],
        ),
      ),
    );
  }
}
