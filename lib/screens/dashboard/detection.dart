import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/dashboard/face_detection_camera.dart';
import 'package:tflite/tflite.dart';

class Detection extends StatefulWidget {
  @override
  _DetectionState createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  bool _loading;
  List _outputs;
  File _image;
  int count = 0;
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });

      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return FaceDetectionFromLiveCamera();
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? Container()
                        : Image.file(_image,
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height * 0.6),
                    SizedBox(
                      height: 10,
                    ),
                    _outputs != null
                        ? Column(
                            children: <Widget>[
                              Text(
                                _outputs[0]["label"] == '0 Closed'
                                    ? "Eyes closed"
                                    : "Eyes Open",
                                style: TextStyle(
                                  color: _outputs[0]["label"] == '0 Closed'
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 25.0,
                                ),
                              ),
                              Text(
                                "${(_outputs[0]["confidence"] * 100).toStringAsFixed(0)}%",
                                style: TextStyle(
                                    color: Colors.purpleAccent, fontSize: 20),
                              )
                            ],
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // here
                              ],
                            ),
                          )
                  ],
                ),
              ));
  }
}
