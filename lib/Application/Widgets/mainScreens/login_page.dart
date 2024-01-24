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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                style: LoGinStyle,
              ),
              gyap(30, 0),
              _customTextField('Email', 'eg:faizal@gmail.com',
                  Icons.email_rounded, _emailController, Icons.more_horiz),
              gyap(20, 0),
              _customTextField('Password', '', Icons.lock, _passwordController,
                  Icons.remove_red_eye),
              gyap(10, 0),
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
      TextEditingController controller, IconData suffxicon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 52,
          width: 300,
          child: TextField(
            style: const TextStyle(fontSize: 12, height: 2),
            cursorHeight: 20,
            cursorColor: Colors.black54,
            controller: controller,
            keyboardType: TextInputType.text,
            enabled: true,
            decoration: InputDecoration(
              isCollapsed: true,
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(
                icon,
                color: Colors.blueGrey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              labelText: labeltxt,
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 10,
              ),
              hintText: hinttxt,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
              suffixIcon: Icon(
                suffxicon,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
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
            const Size(250, 45),
          ),
        ),
        child: loading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                buttonText,
                style: TextStyle(fontSize: 14, color: txtColor),
              ),
      ),
    );
  }
}
