import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';
import 'package:stray_dog_app/View/tools/asset.dart';
import 'package:stray_dog_app/View/tools/carousel.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Uri _url = Uri.parse(
      'https://malappuram.nic.in/en/animal-husbandary-department-new/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: appBartitleStyle,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
          gyap(0, 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText('Stray Dogs!'),
                    FadeAnimatedText('A SOCIAL RESPONSIBILITY!!'),
                  ],
                ),
              ),
            ),
            CarouselScreen(
              photos: dogphotos,
            ),
            gyap(20, 0),
            AppText(
              txt:
                  '"Under Stray Dog Management Rules 2001, its illegal for an individual, RWA or estate management to remove or relocate dogs. The dogs have to be sterilized and vaccinated and returned to the same area". ',
              size: 12,
              color: Colors.black45,
            ),
            gyap(20, 0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Stray Dogs: Our Responsibility to  Protect and Care:-',
                      style: HeadStyle,
                    ),
                    AppText(
                      txt: caption,
                      size: 12,
                    ),
                    gyap(20, 0)
                  ],
                ),
              ),
            ),
            TextButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  fixedSize: MaterialStateProperty.all(Size(300, 50))),
              label: Text(
                'Learn more',
                style: buttonStyle,
              ),
              icon: const Icon(
                Icons.next_plan,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('helpScreen');
              },
            ),
            gyap(10, 0)
          ],
        ),
      ),
      drawer: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white70),
        height: 350,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _drawerList(Icons.home, 'Home', () {
              Navigator.pop(context);
            }),
            _drawerList(Icons.person, 'About Us', () {
              _launchUrl();
            }),
            _drawerList(Icons.report, 'Report', () {
              Navigator.pushNamed(context, 'saveScreen');
            }),
            _drawerList(Icons.feedback, 'FeedBack', () => null),
          ],
        ),
      ),
    );
  }

  _drawerList(IconData icon, String txt, Function() action) {
    return TextButton.icon(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.blueGrey),
        ),
        onPressed: action,
        icon: Icon(icon),
        label: AppText(
          txt: txt,
          size: 16,
          color: Colors.blueGrey,
          fw: FontWeight.w700,
        ));
  }

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
