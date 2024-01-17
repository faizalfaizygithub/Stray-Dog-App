import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

class MyCustomTextField extends StatefulWidget {
  @override
  State<MyCustomTextField> createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFildCard(textName: 'Name', count: 1),
        gyap(2, 0),
        TextFildCard(textName: 'Email', count: 1),
        gyap(2, 0),
        TextFildCard(textName: 'Report', count: 4),
        gyap(5, 0),
      ],
    );
  }
}

class TextFildCard extends StatelessWidget {
  String textName;
  int count;

  TextFildCard({required this.textName, required this.count});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          label: AppText(
            txt: textName,
            size: 14,
          ),
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blueAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        maxLines: count,
      ),
    );
  }
}
