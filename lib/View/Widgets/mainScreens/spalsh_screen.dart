import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/signUp_Page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              color: Colors.white,
              height: 200,
              width: 200,
              child: Container(
                child: Image.asset('assets/images/logo5.png',
                    fit: BoxFit.fitWidth),
              )),
        ));
  }
}
