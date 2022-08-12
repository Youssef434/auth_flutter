import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userToAppUser(User? firebaseUser) {
    return firebaseUser != null ? AppUser(firebaseUser.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userToAppUser);
  }

  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      print("Signed in with temporary account.");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userToAppUser(res.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}