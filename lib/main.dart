import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/Widgets/HelpScreen.dart';
import 'package:stray_dog_app/Application/Widgets/homeScreen.dart';
import 'package:stray_dog_app/Application/Widgets/saveScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homeScreen': (context) => HomeScreen(),
        'helpScreen': (context) => HelpWaysScreen(),
        'saveScreen': (context) => CameraLocationScreen()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 50,
            backgroundColor: Color.fromARGB(255, 228, 223, 223),
            centerTitle: true),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}
