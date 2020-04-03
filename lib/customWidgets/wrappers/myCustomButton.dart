import 'package:flutter/material.dart';

import '../../customPainters/trianglePainter.dart';

class MyRaisedButton extends RaisedButton {

}

class MyCustomButton extends StatelessWidget {
  final String buttonText;
  final Function buttonClickHandler;
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  MyCustomButton({this.buttonText, 
                  this.buttonClickHandler, 
                  this.strokeColor, 
                  this.strokeWidth, 
                  this.paintingStyle});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: strokeWidth,
      margin: EdgeInsets.only(top: 5),

      child: new Stack(
        children: <Widget>[

              Align(
                alignment: Alignment.bottomCenter,
                child: RawMaterialButton(
                  onPressed: buttonClickHandler,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: strokeColor,
                      strokeWidth: strokeWidth,
                      paintingStyle: paintingStyle,
                    ),
                    child: Container(
                      height: strokeWidth,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Text(buttonText),
              )

        ],
      ),        

    );

  }
}