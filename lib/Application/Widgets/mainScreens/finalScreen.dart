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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app))
          ],
          title: Text(
            'Report Summary',
            style: titleStyle,
          ),
        ),
        body: ListView(
          children: [
            gyap(20, 0),
            Image.asset('assets/images/tnk.png'),
            gyap(50, 0),
            const Divider(
              thickness: 5,
              endIndent: 20,
              indent: 20,
              color: Colors.grey,
            ),
            ContactUs(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('adminScreen');
                },
                child: AppText(txt: 'For Admin')),
            Card(
              color: Color.fromARGB(255, 228, 223, 223),
              margin: EdgeInsets.only(right: 10),
              child: TextButton.icon(
                label: Text(
                  'Exit',
                  style: titleStyle,
                ),
                icon: Icon(Icons.exit_to_app_rounded),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
