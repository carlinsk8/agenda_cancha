import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'input_decorations.dart';
import '/domain/entities/agenda.dart';
import '/domain/entities/cancha.dart';
import '/domain/blocs/agenda/agenda_bloc.dart';
import '/domain/blocs/form_agenda/form_agenda_bloc.dart';

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

  @override
  void initState() {
    BlocProvider.of<AgendaBloc>(context).add(ChangeMsjErrorAgenda(null));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormAgendaBloc, FormAgendaState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo no puede ser vacio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: dateController,
                  autocorrect: false,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
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
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      dateController.text = formattedDate;
                      BlocProvider.of<FormAgendaBloc>(context)
                          .add(SetDateAgenda(formattedDate));
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo no puede ser vacio';
                    }
                    return null;
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
                    // final agenda = Agenda(
                    //   name: widget.cancha.name,
                    //   imgUrl: widget.cancha.imgUrl,
                    //   user: userController.text,
                    //   date: '${state.date}',
                    //   clima: Clima('soleado', '25c°'),
                    // );
                    Map<String, dynamic> body = {
                      'name': widget.cancha.name,
                      'imgUrl': widget.cancha.imgUrl,
                      'user': userController.text,
                      'date': '${state.date}',
                    };
                    final agenda = Agenda.fromMap(body);
                    if (state.formKey.currentState!.validate()) {
                      BlocProvider.of<AgendaBloc>(context)
                          .add(AddAgenda(agenda));
                      FocusScope.of(context).unfocus();
                      await Future.delayed(const Duration(seconds: 1));
                      final msj = BlocProvider.of<AgendaBloc>(context)
                          .state
                          .msjLimitAdd;
                      if (msj != null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('No se pudo Agendar'),
                            content: Text(msj),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Ok'),
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Navigator.pushReplacementNamed(context, 'home');
                      }
                    }
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
                    if (state is LoadingAgenda) {
                      return const Text('Cargando...');
                    }

                    return Container();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
