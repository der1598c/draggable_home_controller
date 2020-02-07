import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class ZoomableScreen extends StatefulWidget {
  final Widget child;

  const ZoomableScreen({Key key, this.child}) : super(key: key);
  @override
  _ZoomableScreenState createState() => _ZoomableScreenState();
}

class _ZoomableScreenState extends State<ZoomableScreen> {
  Matrix4 matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
        setState(() {
          matrix = m;
        });
      },
      shouldTranslate: false,
      shouldScale: false,
      shouldRotate: false,
      clipChild: false,
      child: Transform(
        transform: matrix,
        child: Container(
          color: Colors.black,
          child: widget.child,
        ),
      ),
    );
  }
}