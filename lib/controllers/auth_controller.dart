import 'dart:async';

import 'package:checkup/helpers/gravatar.dart';
import 'package:checkup/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' show Logger;

class AuthController extends GetxController {
  static AuthController to = Get.find();

  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fsDB = FirebaseFirestore.instance;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.onClose();
  }

  @override
  Future<void> onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  Future<void> handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await getFirestoreUser();
    }

    if (_firebaseUser == null) {
      Get.offAllNamed('/signin');
    } else {
      Get.offAllNamed('/tabbar');
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    return _fsDB
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return _fsDB.doc('/users/${firebaseUser.value!.uid}').get().then(
          (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!),
        );
  }

  //Method to handle user sign in using email and password
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      emailController.clear();
      passwordController.clear();
    } catch (e) {
      Logger().e(e);
      Get.snackbar(
        'Sign In Error',
        'Login failed: email or password incorrect.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 7),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // User registration using email and password
  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((result) async {
        final Gravatar gravatar = Gravatar(emailController.text);
        final String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        //create the new user object
        final UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          name: nameController.text,
          photoUrl: gravatarUrl,
          dateOfBirth: DateTime.parse(dobController.text),
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        emailController.clear();
        passwordController.clear();
        nameController.clear();
        dobController.clear();
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);

      Get.snackbar(
        'Sign In Error',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  //password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar(
        'Password Reset Email Sent',
        'Check your email and follow the instructions to reset your password.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      Get.snackbar(
        'Password Reset Email Failed',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 10),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // Sign out
  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    try {
      _fsDB.doc('/users/${_firebaseUser.uid}').set(user.toMap());
    } catch (e) {
      Logger().e(e);
    }
  }
}
