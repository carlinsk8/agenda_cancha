import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/blocs/agenda/agenda_bloc.dart';
import 'domain/blocs/canchas/canchas_bloc.dart';
import 'domain/blocs/form_agenda/form_agenda_bloc.dart';
import 'ui/pages/agenda/agenda_page.dart';
import 'ui/pages/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CanchasBloc()),
        BlocProvider(create: (_) => AgendaBloc()),
        BlocProvider(create: (_) => FormAgendaBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'agenda': (_) => const AgendaPage(),
        },
      ),
    );
  }
}
