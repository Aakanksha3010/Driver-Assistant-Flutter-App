import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/screens/auth.dart';


class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({Key key, @required this.username}) : super (key:key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              await googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body:Center(
        child:Column(
          children: [
          Container(
            child: ElevatedButton.icon(
            icon:Icon(Icons.image),
            onPressed: () {},
            label : Text('Select image',textAlign: TextAlign.center,style: GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold)), 
          ),
        ),
        ],
        ),

        

      ),
      
    );
  }
}