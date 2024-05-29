import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';
import 'package:stray_dog_app/View/tools/GetInTouch.dart';
import 'package:stray_dog_app/View/tools/my_button.dart';

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
            // TextButton.icon(
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            //     fixedSize: MaterialStateProperty.all(
            //       Size(300, 50),
            //     ),
            //   ),
            //   label: Text(
            //     'Sign Out',
            //     style: buttonStyle,
            //   ),
            //   icon: const Icon(
            //     Icons.exit_to_app_rounded,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //     Navigator.of(context).pushNamed('loginPage');
            //   },
            // ),

            MyButton(
                buttonText: 'Sign Out',
                ontap: () {
                  signout();
                },
                buttoncolor: Colors.blueGrey,
                textStyle: buttonStyle),
          ],
        ),
      ),
    );
  }

  signout() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Are you sure want to sign out?',
              style: smallTexts,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('N0'),
              ),
              MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('loginPage');
                },
                child: Text('YES'),
              ),
            ],
          );
        });
  }
}
