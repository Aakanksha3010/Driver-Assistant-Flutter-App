import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'detection.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      auth
                          .signOut()
                          .then((value) => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                  (route) => false))
                          .catchError((err) {
                        print("Error occured $err");
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Driver',
                    style: TextStyle(
                        fontFamily: 'LexendDeca',
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0)),
                SizedBox(width: 10.0),
                Text('Assistant',
                    style: TextStyle(
                        fontFamily: 'LexendDeca',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        fontSize: 30.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      "Let's get started...",
                      style: TextStyle(
                        fontFamily: "LexendDeca",
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 350.0,
                      child: Lottie.asset("assets/lottie/meditation.json"),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Detection()));
                      },
                      child: Container(
                          height: 65.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFF1C1428)),
                          child: Center(
                              child: Icon(
                            Icons.camera,
                            size: 35.0,
                            color: Colors.white,
                          ))),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
