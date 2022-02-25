import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/blocs/agenda/agenda_bloc.dart';
import '/domain/blocs/canchas/canchas_bloc.dart';
import '/ui/pages/home/widgets/slide_card.dart';
import '/ui/pages/home/widgets/card_agenda.dart';
import '/ui/widgets/custom_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    BlocProvider.of<CanchasBloc>(context).add(GetCanchasList());
    BlocProvider.of<AgendaBloc>(context).add(GetAgendas());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomTilte(
              title: 'Agendamiento de canchas',
            ),
            BlocBuilder<CanchasBloc, CanchasState>(
              builder: (context, state) {
                return SlideCard(
                  canchas: state.listCancha,
                  title: 'Seleccione su cancha de tenis',
                );
              },
            ),
            const CustomTilte(
              title: 'Canchas agendadas',
            ),
            listCanchasAgendadas()
          ],
        ),
      ),
    );
  }

  Expanded listCanchasAgendadas() {
    return Expanded(
      child: BlocBuilder<AgendaBloc, AgendaState>(
        builder: (context, state) {
          if (state is AgendaListSetState || state is MsjErrorAddSetState) {
            return ListView.builder(
              itemCount: state.listAgenta.length,
              itemBuilder: (_, int i) {
                return CardAgenda(
                  agenda: state.listAgenta[i],
                );
              },
            );
          } else {
            return const Text('No hay canchas agendadas');
          }
        },
      ),
    );
  }
}
