import 'package:flutter/material.dart';
import 'package:agenda_cancha/domain/entities/agenda.dart';

class CardAgenda extends StatelessWidget {
  final Agenda agenda;
  const CardAgenda({
    Key? key,
    required this.agenda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: AssetImage(agenda.imgUrl),
                    width: 200,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agenda.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Agendado por: ${agenda.user}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Fecha: ${agenda.date}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              // Icon(
              //   Icons.wb_sunny,
              //   color: Colors.yellow[800],
              // ),
              // Icon(
              //   Icons.cloud,
              //   color: Colors.blue[800],
              // ),
              Icon(
                Icons.cloud,
                color: Colors.grey[800],
              ),
              Text(agenda.clima.grado),
              IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Eliminar agenda de cancha'),
                    content: const Text('Esta seguro de eliminar'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Sí'),
                        child: const Text('Sí'),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
