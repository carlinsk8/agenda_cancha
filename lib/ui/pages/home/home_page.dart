import 'package:agenda_cancha/domain/repositories/home/static_canchas_repository.dart';
import 'package:agenda_cancha/ui/pages/bloc/agenda/agenda_bloc.dart';
import 'package:agenda_cancha/ui/pages/home/bloc/canchas/canchas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/pages/home/widgets/card_agenda.dart';
import '/ui/pages/home/widgets/slide_card.dart';
import '/ui/widgets/custom_title.dart';
import '/domain/entities/agenda.dart';
import '/domain/entities/cancha.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    BlocProvider.of<CanchasBloc>(context).add(GetCanchasList());
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
                  title: 'Canchas de tenis',
                );
              },
            ),
            const CustomTilte(
              title: 'Canchas agendadas',
            ),
            Expanded(
              child: BlocBuilder<AgendaBloc, AgendaState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.listAgenta.length,
                    itemBuilder: (_, int i) {
                      return CardAgenda(
                        agenda: state.listAgenta[i],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
