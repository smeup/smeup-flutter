import 'package:flutter/material.dart';

import 'applicationInteractions.dart';
import 'barcodeScannerPage.dart';
import 'cameraPage.dart';
import 'customWidgets/wrappers/myBottomBar.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'customWidgets/wrappers/myButton.dart';
import 'main.dart';
import 'models/smeupBottomBarSettings.dart';
import 'offlinePage.dart';
import 'sensorPage.dart';
import 'soundsRecorderPage.dart';
import 'vibrationPage.dart';


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
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const MyLabel('Select the utility to test', 18),

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