import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirbaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> singUpWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context,
      required String userid}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      log(credential.user!.uid.toString());
      prefs.setString('firebaseuserid', credential.user!.uid);
      FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': email,
        'password': password,
        'firebaseuserid': credential.user!.uid,
        'userid': userid
      });
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      if (e.code == 'email-already-in-use') {
        toast("Email Already Use");
        return "";
      }
    }
    return "";

    // catch (e) {
    //   if (e is PlatformException) {
    //     log(e.code);
    //     // if (e.code == 'email-already-in-use') {
    //     //   Navigator.pushAndRemoveUntil(
    //     //       context,
    //     //       MaterialPageRoute(builder: (context) => LoginScreen()),
    //     //       (route) => false);
    //     // }
    //   }
    //   // log("Some error occur $e");
    // }
  }

  Future<bool?> singInWithEmailAndPassword(
      String email, String password, WidgetRef ref) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      ref.watch(loginProvider.notifier).state = true;
      prefs.setString('firebaseuserid', credential.user!.uid);
      return true;
    } catch (e) {
      log("some error occur");
    }
    return false;
  }
}
