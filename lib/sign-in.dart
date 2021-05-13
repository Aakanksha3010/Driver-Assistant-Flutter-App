import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User user;


  String name;
  String email;
  String imageUrl;

  Future<User> googleSignIn() async {
                    await Firebase.initializeApp();
                    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
                    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
                    final AuthCredential credential = GoogleAuthProvider.credential(
                      idToken: googleSignInAuthentication.idToken,
                      accessToken: googleSignInAuthentication.accessToken,
                    );
                  User user = (await auth.signInWithCredential(credential)).user;
                    if (user != null) {
                      name = user.displayName;
                      email = user.email;
                      imageUrl = user.photoURL;
                    }
                  return user;
  }
  void signOut() => auth.signOut();
  User checkUser() => (user.toString() == null ? user : null);
}
final AuthService authService = AuthService();
