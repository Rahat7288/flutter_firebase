// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter_firebase/constants/db_constant.dart';
import 'package:flutter_firebase/model/custom_error.dart';

// all those functions used here are firebase auth instance

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();
// function for signup for new user
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // singedInUser checking the the user is empty or not
      final signedInUser = userCredential.user!;
      // if the user is empty the it will wait for the new results to store
      await userRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage': '',
        'point': 0,
        'rank': 'bronze',
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter error/ server_error',
      );
    }
  }

// function for signin for the older user
  Future<void> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter error/ server_error',
      );
    }
  }

  // function for signout for the user

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
