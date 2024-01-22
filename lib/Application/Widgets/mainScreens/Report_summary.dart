import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/Widgets/GetInTouch.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';

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
                  Navigator.of(context).pushNamed('adminScreen');
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
            Container(
              child: Column(
                children: [
                  Image.asset('assets/images/tnku.jpg'),
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
            ),
            const ContactUs(),
            Card(
              color: Colors.blueGrey,
              margin: const EdgeInsets.only(right: 10),
              child: TextButton.icon(
                label: Text(
                  'Sign Out',
                  style: titleStyle,
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
            ),
          ],
        ),
      ),
    );
  }
}
