import 'package:flutter/material.dart';
import 'package:smeup_flutter/applicationInteractions.dart';
import 'package:smeup_flutter/barcodeScannerPage.dart';
import 'package:smeup_flutter/cameraPage.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myBottomBar.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myLabel.dart';
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/smeupBottomBarSettings.dart';
import 'package:smeup_flutter/offlinePage.dart';
import 'package:smeup_flutter/sensorPage.dart';
import 'package:smeup_flutter/soundsRecorderPage.dart';
import 'package:smeup_flutter/vibrationPage.dart';

import 'customWidgets/wrappers/myButton.dart';

class UtilitiesPage extends StatefulWidget {
  UtilitiesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UtilitiesPageState createState() => _UtilitiesPageState();
}
 
class _UtilitiesPageState extends State<UtilitiesPage> {

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
            MyLabel('Select the utility to test', 18),

            MyButton('Camera',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraPage()),
              );
            }),     

             MyButton('Sensors',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SensorPage()),
              );
            }),     

            MyButton('Vibration',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VibrationPage( title: "Vibration Example", )),
              );
            }),     

            MyButton('Barcode Scanner',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarcodeScannerPage( title: "Barcode Scanner Example", )),
              );
            }),     

            MyButton('Sounds Recorder',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SoundsRecorderPage( title: "Sounds Recorder Example", )),
              );
            }),     

            MyButton('Applications Interaction',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApplicationInteractionsPage( title: "Applications Interaction Example", )),
              );
            }),     

            MyButton('Offline',  () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfflinePage()),
              );
            }),     

             MyButton('Play Notification',  () { 
              MyApp.notificationsService.playError();
            }),     

          ],
        ),
      ),
      
      bottomNavigationBar: MyBottomBar(SmeupBottomBarSettings(refreshData: true, settings: true)),

    );
  }
}