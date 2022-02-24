import 'package:flutter/material.dart';

import 'widgets/card_image_hero.dart';
import 'widgets/form_agenda.dart';
import '/domain/entities/cancha.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({Key? key}) : super(key: key);

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
