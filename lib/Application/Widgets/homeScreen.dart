import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/Widgets/carousel.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';
import 'package:stray_dog_app/Application/tools/asset.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: titleStyle,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ),
          gyap(0, 10)
        ],
      ),
      body: ListView(
        children: [
          gyap(20, 0),
          Container(
            margin: EdgeInsets.only(top: 10, left: 110),
            height: 100,
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText('Stray Dogs!'),
                  FadeAnimatedText('A SOCIAL RESPONSIBILITY!!'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
          CarouselScreen(
            photos: dogphotos,
          ),
          gyap(20, 0),
          Card(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  '  Stray Dogs: Our Responsibility to  Protect and Care:-',
                  style: HeadStyle,
                ),
                AppText(
                  txt: caption,
                  size: 16,
                ),
                gyap(20, 0)
              ],
            ),
          ),
          Card(
            color: Color.fromARGB(255, 228, 223, 223),
            margin: EdgeInsets.only(right: 10),
            child: TextButton.icon(
              label: Text(
                'Learn more',
                style: titleStyle,
              ),
              icon: Icon(Icons.next_plan),
              onPressed: () {
                Navigator.of(context).pushNamed('helpScreen');
              },
            ),
          ),
          gyap(10, 0)
        ],
      ),
      drawer: Drawer(),
    );
  }
}
