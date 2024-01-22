import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stray_dog_app/Application/tools/AppText.dart';
import 'package:stray_dog_app/Domain/controller/firebase_auth_services.dart';

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
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(children: [
              Text(
                'Welcome Back',
                style: HeadStyle,
              ),
              gyap(10, 0),
              Text(
                'Signup your Account to access  \n our service..',
                style: smallTexts,
              ),
              gyap(20, 0),
              _customTextField('username', 'eg:Muhammed Faizal', Icons.person,
                  usernameController),
              gyap(20, 0),
              _customTextField(
                'email',
                'eg:faizalfaizy648@gmail.com',
                Icons.email,
                _emailController,
              ),
              gyap(20, 0),
              _customTextField(
                'password',
                '',
                Icons.lock,
                _passwordController,
              ),
              gyap(20, 0),
              _customButton(() {
                _signUp();
              }, 'Sign Up', Colors.blueGrey, Colors.white)
            ]),
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
                  ))
            ],
          )
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

  Widget _customTextField(
    String labeltxt,
    String hinttxt,
    IconData icon,
    TextEditingController controller,
  ) {
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
                fontSize: 13,
              ),
              hintText: hinttxt,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
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
