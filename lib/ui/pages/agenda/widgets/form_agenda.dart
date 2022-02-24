import 'package:agenda_cancha/domain/entities/agenda.dart';
import 'package:agenda_cancha/domain/entities/cancha.dart';
import 'package:agenda_cancha/ui/pages/bloc/agenda/agenda_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'input_decorations.dart';

class FormReserva extends StatefulWidget {
  final Cancha cancha;
  const FormReserva({
    Key? key,
    required this.cancha,
  }) : super(key: key);

  @override
  State<FormReserva> createState() => _FormReservaState();
}

class _FormReservaState extends State<FormReserva> {
  final userController = TextEditingController();
  final dateController = TextEditingController();
  String? formattedDate;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              controller: userController,
              decoration: InputDecorations.authInputDecoration(
                hintText: '¿Quien agenda?',
                labelText: 'Nombre:',
                prefixIcon: Icons.account_circle_outlined,
              ),
              onChanged: (value) {},
              validator: (value) {
                return (value != null && value.isEmpty)
                    ? null
                    : 'Este campo no puede esta vacio';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: dateController,
              autocorrect: false,
              decoration: InputDecorations.authInputDecoration(
                hintText: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                labelText: 'Fecha:',
                prefixIcon: Icons.calendar_today,
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                  dateController.text = '$formattedDate';
                  setState(() {});
                }
              },
              validator: (value) {
                return (value != null && value.isEmpty)
                    ? null
                    : 'Este campo no puede esta vacio';
              },
            ),
            const SizedBox(height: 10),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blue,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                final agenda = Agenda(
                  name: widget.cancha.name,
                  imgUrl: widget.cancha.imgUrl,
                  user: userController.text,
                  date: '$formattedDate',
                  clima: Clima('soleado', '25c°'),
                );
                BlocProvider.of<AgendaBloc>(context).add(AddAgenda(agenda));
                // FocusScope.of(context).unfocus();

                // Navigator.pushReplacementNamed(context, 'home');
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<AgendaBloc, AgendaState>(
              builder: (context, state) {
                if (state.msjLimitAdd != null) {
                  return Text(
                    '${state.msjLimitAdd}',
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
