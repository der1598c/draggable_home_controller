import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:random_color/random_color.dart';

import 'dart:math';
import './constants.dart' as Constants;
import './moveable_stack_item.dart';
import './room_func_item.dart';

enum RoomType { non, livingRoom, bedroom, bathroom, kitchen, gameRoom }

class ZoomableWidget extends StatefulWidget {
  // final Widget child;
  String uuid;
  Function onDeleteZoomableWidget, onTopZoomableWidget, onSettingZoomableWidget;
  final RoomType roomType;

  // const ZoomableWidget({Key key, this.child}) : super(key: key);
  // const ZoomableWidget({Key key, this.onTapped, this.roomType}) : super(key: key);
  ZoomableWidget(this.uuid, this.onDeleteZoomableWidget, this.onTopZoomableWidget, this.onSettingZoomableWidget, this.roomType);

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {

  // int id = new DateTime.now().millisecondsSinceEpoch;
  
  Matrix4 matrix = Matrix4.identity();
  final Float64List deviceTransform = new Float64List(16)
          ..[0] = 1.0 //
          ..[1] = 0.0 //
          ..[2] = 0.0
          ..[3] = 0.0
          ..[4] = 0.0 //
          ..[5] = 1.0 //
          ..[6] = 0.0
          ..[7] = 0.0
          ..[8] = 0.0
          ..[9] = 0.0
          ..[10] = 1.0
          ..[11] = 0.0
          ..[12] = 0.0 //dx
          ..[13] = 0.0 //dy
          ..[14] = 0.0
          ..[15] = 1.0;
  List<MoveableStackItem> movableItems = [];
  Color color = RandomColor().randomColor();

  int _roomType = RoomType.non.index;
  String _imagePathName;
  Offset _imageSize; //Offset(width, height)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _roomType = widget.roomType.index;
    initImagePathName();

    matrix = Matrix4.fromFloat64List(deviceTransform);
    var list = matrix.storage;
    print('list:\n$list');

    // movableItems.add(MoveableStackItem(Offset(10, 10), onItemTapped, AccessoryType.accessory_A));
    // movableItems.add(MoveableStackItem(Offset(10, 70), onItemTapped, AccessoryType.accessory_B));
    // movableItems.add(MoveableStackItem(Offset(10, 130), onItemTapped, AccessoryType.accessory_C));
    // movableItems.add(MoveableStackItem(Offset(10, 190), onItemTapped, AccessoryType.accessory_D));
  }

  void onCloseButtonTapped() {
    print('onCloseButtonTapped');
    widget.onDeleteZoomableWidget(widget.uuid);
  }

  void onTopButtonTapped() {
    print('onTopButtonTapped');
    widget.onTopZoomableWidget(widget.uuid);
  }

  void onSettingButtonTapped(AccessoryType type) {
    print('onSettingButtonTapped');
    // widget.onSettingZoomableWidget(widget.uuid);

    if(type == AccessoryType.non) {
      setState(() {
        movableItems.clear();
      });
      return;
    }
    //Add moveable item:
    setState(() {
      movableItems.add(MoveableStackItem(Offset(30, 30), onItemTapped, type));
    });
  }

  void onItemTapped() {
    print('onItemTapped');
  }

  void initImagePathName(){
    //livingRoom, bedroom, bathRoom, kitchen, gameRoom
      setState(() {
        switch (RoomType.values[_roomType]) {
          case RoomType.livingRoom:
            _imagePathName = Constants.LIVING_ROOM_IMG_PATH;
            _imageSize = Offset(480 , 381);
            break;
          case RoomType.bedroom:
            _imagePathName = Constants.BEDROOM_IMG_PATH;
            _imageSize = Offset(459 , 373);
            break;
          case RoomType.bathroom:
            _imagePathName = Constants.BATHROOM_IMG_PATH;
            _imageSize = Offset(436 , 333);
            break;
          case RoomType.kitchen:
            _imagePathName = Constants.KITCHEN_IMG_PATH;
            _imageSize = Offset(520 , 367);
            break;
          case RoomType.gameRoom:
            _imagePathName = Constants.GAME_ROOM_IMG_PATH;
            _imageSize = Offset(457 , 382);
            break;
          default:
        }
      });
    }

    Float64List fixRotate(Float64List list) {
      int index = 2; //取至小數第2位
      int fac = pow(10, index);
      list[0] = (list[0] * fac).round() / fac;
      list[1] = (list[1] * fac).round() / fac;
      list[4] = (list[4] * fac).round() / fac;
      list[5] = (list[5] * fac).round() / fac;
      return list;
    }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if(RoomType.non == RoomType.values[_roomType]) return Container();

    return MatrixGestureDetector(
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
        print('m:\n $m \n tm: \n $tm \n sm: \n $sm \n rm \n $rm');
        // print('m:\n$m');
        setState(() {
          // matrix = m;
          var list = fixRotate(m.storage);
          matrix = Matrix4.fromFloat64List(list);
          print('list:\n$list');
          // m.rotateZ(pi /6);
        });
      },
      // shouldScale: false,
      child: Transform(
        // origin: Offset(0,0),
        transform: matrix,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: Container(
              width: _imageSize.dx,
              height: _imageSize.dy,
            // color: color,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(_imagePathName))
              ),
              child: Stack(
                children: <Widget>[
                  Func_Button(Offset(_imageSize.dx - 110, 0), onSettingButtonTapped, FunctionType.on_Setting),
                  Func_Button(Offset(_imageSize.dx - 70, 0), onTopButtonTapped, FunctionType.on_Top),
                  Func_Button(Offset(_imageSize.dx - 30, 0), onCloseButtonTapped, FunctionType.on_Delete),
                  Stack(
                    children: movableItems,
                  )
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}