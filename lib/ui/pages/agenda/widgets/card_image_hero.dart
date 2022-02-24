import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:flutter/material.dart';

class CardImageHero extends StatelessWidget {
  const CardImageHero({
    Key? key,
    required this.cancha,
  }) : super(key: key);

  final Cancha cancha;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cancha.imgUrl,
      child: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: AssetImage(cancha.imgUrl),
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }
}
