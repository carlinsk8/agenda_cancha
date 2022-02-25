import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/blocs/agenda/agenda_bloc.dart';
import '/ui/widgets/custom_title.dart';
import 'widgets/card_agenda.dart';

class AgendaListPage extends StatefulWidget {
  const AgendaListPage({Key? key}) : super(key: key);

  @override
  State<AgendaListPage> createState() => _AgendaListPageState();
}

class _AgendaListPageState extends State<AgendaListPage> {
  @override
  initState() {
    BlocProvider.of<AgendaBloc>(context).add(GetAgendas());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamiento de canchas'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTilte(
                    title: 'Canchas agendadas',
                  ),
                  ElevatedButton(
                    child: const Text('Agendar'),
                    onPressed: () => Navigator.pushNamed(context, 'canchas'),
                  )
                ],
              ),
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
          if (state.listAgenta.isNotEmpty) {
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
