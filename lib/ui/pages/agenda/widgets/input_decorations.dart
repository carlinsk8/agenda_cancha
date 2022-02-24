import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2)),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.blue) : null,
    );
  }
}
