import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';
import 'package:stray_dog_app/Domain/controller/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var loading = false.obs;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(children: [
              gyap(80, 0),
              Text(
                'Login',
                style: HeadStyle,
              ),
              gyap(30, 0),
              _customTextField('Email', 'eg:faizal@gmail.com',
                  Icons.email_rounded, _emailController),
              gyap(20, 0),
              _customTextField('Password', '', Icons.lock, _passwordController),
              gyap(20, 0),
              _customButton(() {
                _signIn();
              }, 'Login', Colors.blueGrey, Colors.white)
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                txt: "Don't have an account ?",
                size: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('signupScreen');
                  },
                  child: AppText(
                    txt: 'Sign Up',
                    color: Colors.blue,
                    size: 11,
                  ))
            ],
          )
        ]),
      ),
    );
  }

// wrong email message popup
  void wrongEmailOrpasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: AppText(
              txt: 'incorrect email or Password',
              size: 12,
              color: Colors.red,
            ),
          );
        });
  }

  void _signIn() async {
    try {
      loading.value = true;

      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.SignInWithEmailAndPassword(email, password);
      loading.value = false;
      if (user != null) {
        print('User sUccesfully signIN');
        Navigator.of(context).pushNamed('homeScreen');
        loading.value = false;
      } else {
        wrongEmailOrpasswordMessage();
        loading.value = false;
      }
    } catch (e) {
      Get.snackbar('incorrect', '$e');
    }
  }

  Widget _customTextField(String labeltxt, String hinttxt, IconData icon,
      TextEditingController controller) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          enabled: true,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black26,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: labeltxt,
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
              hintText: hinttxt,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 11,
              ),
              suffixText: 'OK'),
        ),
      ),
    ]);
  }

  Widget _customButton(
    final void Function() buttonAction,
    final String buttonText,
    final Color buttonColor,
    final Color txtColor,
  ) {
    return Obx(
      () => ElevatedButton(
        onPressed: buttonAction,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          minimumSize: MaterialStateProperty.all(
            const Size(250, 50),
          ),
        ),
        child: loading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                buttonText,
                style: TextStyle(fontSize: 15, color: txtColor),
              ),
      ),
    );
  }
}
