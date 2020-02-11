import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  final String text;
  final double fontSize;

  MyLabel(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(fontSize: this.fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}
