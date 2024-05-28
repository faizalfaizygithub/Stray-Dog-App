import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labeltxt;
  final String hinttxt;
  IconData? suffxicon;

  MyTextField(
      {super.key,
      required this.controller,
      required this.prefixIcon,
      required this.labeltxt,
      required this.hinttxt,
      this.suffxicon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 12),
      cursorColor: Colors.black54,
      controller: controller,
      keyboardType: TextInputType.text,
      cursorHeight: 20,
      enabled: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(13),
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blueGrey,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
            ),
            borderRadius: BorderRadius.all(Radius.circular(13))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        labelText: labeltxt,
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 10,
        ),
        hintText: hinttxt,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 10,
        ),
        suffixIcon: Icon(
          suffxicon,
          size: 20,
          color: Colors.black54,
        ),
      ),
    );
  }
}
