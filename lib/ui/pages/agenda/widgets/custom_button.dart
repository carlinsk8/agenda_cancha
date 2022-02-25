import 'package:flutter/material.dart';

class CustonButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustonButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.blue,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 15,
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
