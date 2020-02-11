import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myCamera.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  @override
  Widget build(BuildContext context) {
           return MyCamera();
  }
}