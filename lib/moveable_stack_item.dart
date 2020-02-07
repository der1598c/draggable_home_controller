import 'package:flutter/material.dart';

import 'package:random_color/random_color.dart';

enum AccessoryType { non, accessory_A, accessory_B, accessory_C, accessory_D }

class MoveableStackItem extends StatefulWidget {

  Offset pos;
  Function onTapped;
  final AccessoryType accessoryType;

  MoveableStackItem(this.pos, this.onTapped, this.accessoryType);

  @override State<StatefulWidget> createState() { 
   return _MoveableStackItemState(); 
  } 
}
class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Color color;

  int _accessoryType = AccessoryType.non.index;
  String _imagePathName;
  Offset _imageSize; //Offset(width, height)


  @override
  void initState() {
    super.initState();

    color = RandomColor().randomColor();
    xPosition = widget.pos.dx;
    yPosition = widget.pos.dy;
    
    _accessoryType = widget.accessoryType.index;
    initImagePathName();
    _imageSize = Offset(50 , 50);
  }

  void initImagePathName(){
    //livingRoom, bedroom, bathRoom, kitchen, gameRoom
      setState(() {
        switch (AccessoryType.values[_accessoryType]) {
          case AccessoryType.accessory_A:
            _imagePathName = "images/accessory_A.png";
            break;
          case AccessoryType.accessory_B:
            _imagePathName = "images/accessory_B.png";
            break;
          case AccessoryType.accessory_C:
            _imagePathName = "images/accessory_C.png";
            break;
          case AccessoryType.accessory_D:
            _imagePathName = "images/accessory_D.png";
            break;
          default:
        }
      });
    }

  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onTap: widget.onTapped,
        onPanUpdate: (tapInfo) {
          setState(() {
            print("Screen width: $width, height: $height");
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: _imageSize.dx,
          height: _imageSize.dy,
          // color: color,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(_imagePathName), fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}