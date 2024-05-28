import 'package:flutter/material.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';

class GoogleAuthButton extends StatelessWidget {
  final String img;
  final String txt;
  const GoogleAuthButton({super.key, required this.img, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueGrey)),
      height: 45,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(img),
          Text(
            txt,
            style: smallTexts,
          ),
        ],
      ),
    );
  }
}




  // wrong email message popup
