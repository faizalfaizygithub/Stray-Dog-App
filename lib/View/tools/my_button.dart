import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  final Color buttoncolor;
  final Function() ontap;
  final TextStyle textStyle;
  const MyButton(
      {super.key,
      required this.buttonText,
      required this.ontap,
      required this.buttoncolor,
      required this.textStyle});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var loading = false.obs;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Obx(
        () => Container(
          height: 45,
          width: 250,
          decoration: BoxDecoration(
            color: widget.buttoncolor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: loading.value
              ? const CircularProgressIndicator(color: Colors.blueGrey)
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.buttonText,
                    style: widget.textStyle,
                  ),
                ),
        ),
      ),
    );
  }
}
