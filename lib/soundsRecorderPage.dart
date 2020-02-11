import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/mySoundRecorder.dart';

class SoundsRecorderPage extends StatefulWidget {
  SoundsRecorderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SoundsRecorderPageState createState() => _SoundsRecorderPageState();
}

class _SoundsRecorderPageState extends State<SoundsRecorderPage> {

  @override
  Widget build(BuildContext context) {
           return MySoundsRecorder();
  }
}