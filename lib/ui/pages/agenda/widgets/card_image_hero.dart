import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/blocs/form_agenda/form_agenda_bloc.dart';
import '/domain/entities/cancha.dart';

class CardImageHero extends StatelessWidget {
  const CardImageHero({
    Key? key,
    required this.cancha,
  }) : super(key: key);

  final Cancha cancha;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: cancha.imgUrl,
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: AssetImage(cancha.imgUrl),
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        BlocBuilder<FormAgendaBloc, FormAgendaState>(
          builder: (context, state) {
            if (state is DateSetState) {
              return Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.5,
                        spreadRadius: 1.5,
                        offset: Offset(0.0, 0.5),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    children: [
                      FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage('${state.newIcon}'),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      Text('${state.newGrado}'),
                      Text('${state.newText}'),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
