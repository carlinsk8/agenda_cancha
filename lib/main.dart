import 'package:agenda_cancha/ui/pages/bloc/agenda/agenda_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/pages/agenda/agenda_page.dart';
import 'ui/pages/home/bloc/canchas/canchas_bloc.dart';
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
