import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/HomeScreen.dart';
import 'package:flutter_application_1/screens/auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
   @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }
  Future initializeUser() async{
    await Firebase.initializeApp();
    final User firebaseUser = await FirebaseAuth.instance.currentUser;
    await firebaseUser.reload();
    _user = await _auth.currentUser;
  }
  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(username: _auth.currentUser.displayName)),
            (Route<dynamic> route) => false),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Color(0xff03203C),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://image.freepik.com/free-vector/woman-face-scan-process-gadget_24908-56374.jpg'),
                radius: 70,
              ),
            ),
            SizedBox(height: 25),
            Text('Driver Assistant',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber[200]),textAlign: TextAlign.center),
            SizedBox(height: 25),
            ElevatedButton.icon(
              label: Text("Let's get started"),
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
              },
            ),
          ],
        ),
      );
  }
}

// class LoginScreen extends StatelessWidget {
//   final Color pColor = Color(0xff18203d);
//   final Color sColor = Color(0xff232c51);
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController psswdController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0.0),
//       backgroundColor: pColor,
//       body: Container(
//         alignment: Alignment.topCenter,
//         margin: EdgeInsets.symmetric(horizontal: 30),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Sign-in to experience magic',style:GoogleFonts.openSans(color: Colors.white, fontSize: 28),textAlign: TextAlign.center,),
//               SizedBox(height: 20),
//               Text("Enter your email and password",style:  GoogleFonts.openSans(color: Colors.white, fontSize: 14),textAlign: TextAlign.center),
//               SizedBox(height: 50),
//               _buildTextField(nameController, Icons.account_circle, 'Username'),
//                SizedBox(height: 20),
//               _buildTextField(psswdController, Icons.lock, 'Password'),
//               SizedBox(height: 30),
//               MaterialButton(
//                 elevation: 0.0,
//                 height: 25,
//                 minWidth: double.maxFinite,
//                 onPressed: () {},
//                 child: Text("Login",style: TextStyle(fontSize: 16,color: Colors.white)),
//                 color: Colors.blue,
//               ),
//               SizedBox(height: 20),
//               MaterialButton(
//                 elevation: 0.0,
//                 height: 50,
//                 minWidth: double.maxFinite,
//                 onPressed: () {
//                   //Google sign-in logicc
                  
//                 },
//                 color: Colors.blue,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(FontAwesomeIcons.google),
//                     SizedBox(width: 10),
//                     Text('Sign-in with Google',style: TextStyle(fontSize: 16,color: Colors.white)),
//                   ],
//                 ),
//                 textColor: Colors.white,
//               ),
//               SizedBox(height: 100),
//             ],
//           ),
//         ),
//       ), 
//     );
//   } 

// _buildTextField(TextEditingController controller,IconData icon,String labelText){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//       decoration: BoxDecoration(
//         color: sColor,border: Border.all(color: Colors.blue)),
//         child: TextField(
//           controller: controller,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             labelText: labelText,
//             labelStyle: TextStyle(color: Colors.white),
//             icon: Icon(icon,color: Colors.white),
//             border: InputBorder.none,
//           ),
//         ),
//     );
    
//   }
// }





