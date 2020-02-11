import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/mySensor.dart';

class SensorPage extends StatefulWidget {
  SensorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {

  @override
  Widget build(BuildContext context) {
           return MySensor();
  }
}