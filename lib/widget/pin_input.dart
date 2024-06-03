import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildPinInput(BuildContext context, TextEditingController controller,bool _obscureText) {

  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextField(
      controller: controller,
      obscureText: _obscureText,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
      enableInteractiveSelection: false, // Tambahkan baris ini
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (value) {
        // Move focus to the next TextField when a digit is entered
        if (value.isNotEmpty) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}