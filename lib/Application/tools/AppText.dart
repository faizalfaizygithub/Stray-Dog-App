import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String txt;
  final double? size;
  final dynamic? fw;

  final Color? color;
  AppText({super.key, required this.txt, this.size, this.fw, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: size,
        fontWeight: fw,
        color: color,
      ),
    );
  }
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
  );
}

TextStyle get smallTexts {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
  );
}

Widget gyap(final double? hgyap, final double? wgyap) {
  return SizedBox(
    height: hgyap,
    width: wgyap,
  );
}

TextStyle get HeadStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 48, 32, 32)),
  );
}

Widget waysCard(
  final heading,
  final image,
  final text,
) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Column(
      children: [
        gyap(10, 0),
        Text(
          heading,
          style: titleStyle,
        ),
        gyap(10, 0),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.black,
            height: 230,
            width: 400,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        gyap(10, 0),
        AppText(
          txt: text,
          size: 12,
          color: Colors.black,
        ),
        gyap(10, 0),
      ],
    ),
  );
}
