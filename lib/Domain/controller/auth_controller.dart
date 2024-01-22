import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stray_dog_app/Application/Widgets/mainScreens/homeScreen.dart';
import 'package:stray_dog_app/Data/model/user_model.dart';

class AuthController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController usernameController = TextEditingController();
  TextEditingController signupemailController = TextEditingController();
  TextEditingController signuppasswordController = TextEditingController();
  TextEditingController loginemailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  TextEditingController resetemailController = TextEditingController();
  var loading = false.obs;

  //setup 2 create functions

  //Create Account with email and password

  SignUp() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: signupemailController.text,
          password: signupemailController.text);
      await addUser();
      //   await verifyEmail();
      Get.to(() => const HomeScreen());
      loading.value = false;
    } catch (e) {
      print('some error accured');
      loading.value = false;
    }
  }

  //add user to database
  addUser() async {
    UserModel user = UserModel(
        username: usernameController.text,
        email: auth.currentUser?.email ?? '');
    await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('profile')
        .add(user.toMap());
  }

  //signout

  signOut() async {
    await auth.signOut();
  }

  //SignIn
  SignIn() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: loginemailController.text,
          password: loginpasswordController.text);
    } catch (e) {
      Get.snackbar('error', '$e');
    }
  }

  //verifyemail
  // verifyEmail() async {
  //  await auth.currentUser?.sendEmailVerification();
  // Get.snackbar('email', 'send');}
}
