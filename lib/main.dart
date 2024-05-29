import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/HelpScreen.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/adminPanel.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/camLocaScreen.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/finalScreen.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/homeScreen.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/login_page.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/signUp_Page.dart';
import 'package:stray_dog_app/View/Widgets/mainScreens/spalsh_screen.dart';

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
    return GetMaterialApp(
      routes: {
        'splashScreen': (context) => const SplashScreen(),
        'signupScreen': (context) => SignUpScreen(),
        'loginPage': (context) => LoginPage(),
        'homeScreen': (context) => const HomeScreen(),
        'helpScreen': (context) => const HelpWaysScreen(),
        'saveScreen': (context) => const CameraLocationScreen(),
        'finalScreen': (context) => const FinalScreen(),
        'adminScreen': (context) => const AdminPanel(),
      },
      initialRoute: 'splashScreen',
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            toolbarHeight: 70,
            backgroundColor: Colors.blueGrey,
            centerTitle: true),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: Colors.white),
      ),
      home: const HomeScreen(),
    );
  }
}
