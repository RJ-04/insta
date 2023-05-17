import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram_flutter/resources/storage_method.dart';
import 'package:instagram_flutter/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* sign up */

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    String bio = "",
    required Uint8List file,
  }) async {
    String result = "Some error occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        /* register user */

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);

        /* add user to database */

        model.User user = model.User(
          bio: bio,
          followers: [],
          following: [],
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        result = "success";
      } else if (email.isEmpty) {
        result = "Please enter email";
      } else if (password.isEmpty) {
        result = "Please enter password";
      } else if (username.isEmpty) {
        result = "Please enter username";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        result = "The Email is badly formatted";
      } else if (e.code == "weak-password") {
        result = "Please choose a STRONGER Password.";
      } else {
        result = e.toString();
      }
    }
    return result;
  }

  /* log in user */

  Future<String> logInUser(
      {required String email, required String password}) async {
    String result = "Some error occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "success";
      } else if (email.isEmpty) {
        result = "Please enter email";
      } else if (password.isEmpty) {
        result = "Please enter password";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        result = " User not found \n Please check your credentials ";
      } else if (e.code == "wrong-password") {
        result = "incorrect password .";
      } else {
        result = e.toString();
      }
    }
    return result;
  }
}
