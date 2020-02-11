import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myBottomBar.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myLabel.dart';
import 'package:smeup_flutter/models/smeupBottomBarSettings.dart';
import 'package:vibrate/vibrate.dart';
import 'customWidgets/wrappers/myButton.dart';
import 'package:vibration/vibration.dart';

class VibrationPage extends StatefulWidget {
  VibrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VibrationPageState createState() => _VibrationPageState();
}

class _VibrationPageState extends State<VibrationPage> {

  bool _canVibrate = false;

  @override
  void initState() {
    super.initState();
    _checkVibration();
    
  }

  _checkVibration() async {
    
    //_canVibrate = await Vibrate.canVibrate;
    if (await Vibration.hasVibrator()) {
      _canVibrate = true;
    }

    // Vibrate with pauses between each vibration
    final Iterable<Duration> pauses = [
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 1000),
        const Duration(milliseconds: 500),
    ];
    // vibrate - sleep 0.5s - vibrate - sleep 1s - vibrate - sleep 0.5s - vibrate
    Vibrate.vibrateWithPauses(pauses);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: MyLabel(
          widget.title,
          18,
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            _canVibrate
            ? 
            MyButton('Vibrate',  () { 
             Vibrate.vibrate();
             Vibration.vibrate();
            })     
            : MyLabel("Phone Cannot Vibrate", 18),  
            
           
          ],
        ),
      ),
      
      bottomNavigationBar: MyBottomBar(SmeupBottomBarSettings(refreshData: true, settings: true)),

    );
  }
}