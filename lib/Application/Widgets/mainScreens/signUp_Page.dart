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
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(children: [
              Text(
                'Welcome Back',
                style: LoGinStyle,
              ),
              gyap(10, 0),
              Text(
                'Signup your Account to access  \n our service..',
                style: smallTexts,
              ),
              gyap(30, 0),
              _customTextField('username', 'eg:Faizal', Icons.person,
                  Icons.more_horiz, usernameController),
              gyap(20, 0),
              _customTextField(
                'email',
                'eg:faizal123@gmail.com',
                Icons.email,
                Icons.more_horiz,
                _emailController,
              ),
              gyap(20, 0),
              _customTextField(
                'password',
                '',
                Icons.lock,
                Icons.remove_red_eye,
                _passwordController,
              ),
              gyap(20, 0),
              _customButton(() {
                _signUp();
              }, 'Create account', Colors.blueGrey, Colors.white)
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
    IconData suffxicon,
    TextEditingController controller,
  ) {
    return Column(children: [
      Container(
        height: 52,
        width: 300,
        alignment: Alignment.centerLeft,
        child: TextField(
          strutStyle: StrutStyle(fontSize: 10, height: 3.5),
          cursorHeight: 15,
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
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
