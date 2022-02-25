import 'package:flutter/material.dart';

import 'widgets/slide_card.dart';
import '/domain/blocs/canchas/canchas_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanchasPage extends StatefulWidget {
  const CanchasPage({Key? key}) : super(key: key);

  @override
  State<CanchasPage> createState() => _CanchasPageState();
}

class _CanchasPageState extends State<CanchasPage> {
  @override
  void initState() {
    BlocProvider.of<CanchasBloc>(context).add(GetCanchasList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione su cancha de tenis'),
      ),
      body: BlocBuilder<CanchasBloc, CanchasState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SlideCard(
              canchas: state.listCancha,
            ),
          );
        },
      ),
    );
  }
}
