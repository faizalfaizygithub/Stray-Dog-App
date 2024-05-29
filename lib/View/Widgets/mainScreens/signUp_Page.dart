import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stray_dog_app/Controller/firebase_auth_services.dart';
import 'package:stray_dog_app/View/tools/AppText.dart';
import 'package:stray_dog_app/View/tools/googlAuthButton.dart';
import 'package:stray_dog_app/View/tools/myTextField.dart';
import 'package:stray_dog_app/View/tools/my_button.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var loading = false.obs;

  @override
  void dispose() {
    usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.white54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: ListView(
            padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Register',
                  style: LoGinStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Create your Account to access  \n our service..',
                style: smallTexts,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(100)),
                    color: Colors.blueGrey.shade500),
                height: 380,
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gyap(20, 0),
                      MyTextField(
                          controller: usernameController,
                          prefixIcon: Icons.person,
                          labeltxt: 'Name',
                          hinttxt: 'enter your full name'),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          controller: _emailController,
                          prefixIcon: Icons.email_rounded,
                          labeltxt: 'Email',
                          hinttxt: 'abc@gmail.com'),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          controller: _passwordController,
                          prefixIcon: Icons.lock,
                          labeltxt: 'Password',
                          hinttxt: 'minimum 6 digit'),
                      gyap(20, 0),
                      MyButton(
                          textStyle: buttonStyleForAuth,
                          buttoncolor: Colors.white,
                          buttonText: 'Create account',
                          ontap: () {
                            _signUp();
                          }),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                ' ----------  Or Register with  ----------',
                style: smallTexts,
              ),
              SizedBox(
                height: 20,
              ),
              GoogleAuthButton(
                  img: 'assets/auth/g.webp', txt: 'Continue with google'),
              SizedBox(
                height: 20,
              ),
              GoogleAuthButton(
                  img: 'assets/auth/fb.webp', txt: 'continue with facebook'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    txt: "Already have an account ?",
                    size: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('loginPage');
                    },
                    child: AppText(
                      txt: 'Login',
                      color: Colors.blue,
                      size: 11,
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  void _signUp() async {
    loading.value = true;
    String username = usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.SignUpWithEmailAndPassword(email, password);

    if (user != null) {
      print('User sUccesfully created');
      Navigator.of(context).pushReplacementNamed('homeScreen');
      loading.value = false;
    } else {
      print('some error happend');
      loading.value = false;
    }
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
