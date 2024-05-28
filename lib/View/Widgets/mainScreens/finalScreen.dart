import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';
import 'package:stray_dog_app/View/tools/GetInTouch.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('adminScreen');
                },
                icon: const Icon(
                  Icons.admin_panel_settings_rounded,
                  color: Colors.white,
                  size: 30,
                ))
          ],
          title: Text(
            'Report Summary',
            style: appBartitleStyle,
          ),
        ),
        body: ListView(
          children: [
            gyap(20, 0),
            Column(
              children: [
                Lottie.asset('assets/json/tick.json', height: 300, width: 300),
                Text(
                  'Your submission has been received',
                  style: smallTexts,
                ),
                gyap(20, 0),
                Text(
                  '---------*---------',
                  style: titleStyle,
                ),
              ],
            ),
            const ContactUs(),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                fixedSize: MaterialStateProperty.all(
                  Size(300, 50),
                ),
              ),
              label: Text(
                'Sign Out',
                style: buttonStyle,
              ),
              icon: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed('loginPage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
