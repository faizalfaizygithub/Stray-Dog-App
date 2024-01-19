import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/HelpScreen.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/adminPanel.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/camLocaScreen.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/finalScreen.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/homeScreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homeScreen': (context) => const HomeScreen(),
        'helpScreen': (context) => const HelpWaysScreen(),
        'saveScreen': (context) => const CameraLocationScreen(),
        'finalScreen': (context) => const FinalScreen(),
        'adminScreen': (context) => const AdminPanel(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
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
