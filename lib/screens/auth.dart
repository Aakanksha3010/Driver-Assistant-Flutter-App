import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/HomeScreen.dart';
import 'package:flutter_application_1/screens/dashboard/landing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/sign-in.dart';

String name;
String email;
String imageUrl;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final AuthService authService = AuthService();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Color pColor = Color(0xff18203d);

  final Color sColor = Color(0xff232c51);

  final TextEditingController nameController = TextEditingController();

  final TextEditingController psswdController = TextEditingController();

  bool _validate = false;
  bool visible = true;
  String email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      backgroundColor: pColor,
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign-in to experience magic',
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text("Enter your email and password",
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center),
              SizedBox(height: 50),
              _buildTextField(nameController, Icons.account_circle, 'Email'),
              SizedBox(height: 20),
              _buildTextField(psswdController, Icons.lock, 'Password'),
              SizedBox(height: 30),
              MaterialButton(
                elevation: 0.0,
                height: 50,
                minWidth: double.maxFinite,
                onPressed: () async {
                  try {
                    dynamic results = await auth.signInWithEmailAndPassword(
                        email: nameController.text,
                        password: psswdController.text);
                    if (results != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                          (Route<dynamic> route) => false);
                    }
                  } catch (err) {
                    print(err["message"]);
                  }
                },
                child: Text("Login",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          color: sColor,
          border: Border.all(color: Colors.blue)),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          icon: Icon(icon, color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
