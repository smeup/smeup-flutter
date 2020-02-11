import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({ this.strokeColor, 
                    this.strokeWidth, 
                    this.paintingStyle,
                    //this.buttonText 
                    });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
    //this.rotate(canvas, size.width, size.height, 180);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      // point up
      ..moveTo(0, y)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);

      // point down
      // ..moveTo(x / 2, y)
      // ..lineTo(x , 0)
      // ..lineTo(0, 0);

      // point right
      // ..moveTo(x , y / 8)
      // ..lineTo(0 , y / 2)
      // ..lineTo(0, -y / 8)
      // ..moveTo(x , 0);
      
      // cardiac
      // ..moveTo(x , y)
      // ..lineTo(x - (x / 8) , 0)
      // ..lineTo(x - (x / 8) , y)
      // ..lineTo(x - (x / 4) , 0)
      // ..lineTo(x - (x / 2) , y)
      // ..lineTo(0 , 0);
      

  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }

  // void rotate(Canvas canvas, double cx, double cy, double angle) {
  //   canvas.translate(cx, cy);
  //   canvas.rotate(angle);
  //   canvas.translate(-cx, -cy);
  // }
}