import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_button.dart';
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
                  validator: validatorEmpty,
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
                  onTap: onTapDatePicker,
                  validator: validatorEmpty,
                ),
                const SizedBox(height: 10),
                CustonButton(
                  title: 'Guardar',
                  onPressed: () => _onSubmit(state),
                ),
                const SizedBox(height: 10),
                _msjError()
              ],
            ),
          ),
        );
      },
    );
  }

  String? validatorEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede ser vacio';
    }
    return null;
  }

  void onTapDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formattedDate;
      BlocProvider.of<FormAgendaBloc>(context)
          .add(SetDateAgenda(formattedDate));
    }
  }

  BlocBuilder<AgendaBloc, AgendaState> _msjError() {
    return BlocBuilder<AgendaBloc, AgendaState>(
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
    );
  }

  Future<String?> alertMsj(BuildContext context, String msj) {
    return showDialog<String>(
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
  }

  void _onSubmit(FormAgendaState state) async {
    Map<String, dynamic> body = {
      'name': widget.cancha.name,
      'imgUrl': widget.cancha.imgUrl,
      'user': userController.text,
      'date': '${state.date}',
    };
    final agenda = Agenda.fromMap(body);
    if (state.formKey.currentState!.validate()) {
      BlocProvider.of<AgendaBloc>(context).add(AddAgenda(agenda));
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
      final msj = BlocProvider.of<AgendaBloc>(context).state.msjLimitAdd;
      if (msj != null) {
        alertMsj(context, msj);
      } else {
        Navigator.pushReplacementNamed(context, 'home');
      }
    }
  }
}
