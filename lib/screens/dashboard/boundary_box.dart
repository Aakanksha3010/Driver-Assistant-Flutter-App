import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class BoundaryBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;

  BoundaryBox(
      this.results, this.previewH, this.previewW, this.screenH, this.screenW);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      return results.map((re) {
        try {
          if (re["label"] == '0 Closed' && (re["confidence"] * 100 > 85)) {
            print("above");
            FlutterRingtonePlayer.playNotification(volume: 1);
          } else {
            FlutterRingtonePlayer.stop();
          }
        } catch (err) {
          // do nothing
        }
        return Stack(
          children: <Widget>[
            Positioned(
              left: (screenW / 4),
              bottom: -(screenH - 80),
              width: screenW,
              height: screenH,
              child: Text(
                "${re["label"] == '0 Closed' ? "Eyes Closed" : "Eyes Open"} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  backgroundColor: Colors.white,
                  color: re["label"] == '0 Closed' ? Colors.red : Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        );
      }).toList();
    }

    return Stack(
      children: _renderStrings(),
    );
  }
}
