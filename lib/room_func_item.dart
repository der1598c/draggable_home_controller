import 'package:flutter/material.dart';

import './moveable_stack_item.dart';
import './constants.dart' as Constants;

enum FunctionType { non, on_Delete, on_Top, on_Setting }

class Func_Button extends StatefulWidget {

  Offset pos;
  Function onTapped;
  final FunctionType fuctionType;

  Func_Button(this.pos, this.onTapped, this.fuctionType);

  @override State<StatefulWidget> createState() { 
   return _Func_Button_State(); 
  } 
}
class _Func_Button_State extends State<Func_Button> {

  double xPosition = 0;
  double yPosition = 0;

  int _fuctionType = FunctionType.non.index;
  String _imagePathName;
  Offset _imageSize; //Offset(width, height)

  @override
  void initState() {
    super.initState();

    xPosition = widget.pos.dx;
    yPosition = widget.pos.dy;
    
    _fuctionType = widget.fuctionType.index;
    initImagePathName();
    _imageSize = Offset(30 , 30);
  }

  void initImagePathName(){
    /*
    - images/delete_room_btn.png
    - images/top_room_btn.png
    - images/setting_room_btn.png
    */
      setState(() {
        switch (FunctionType.values[_fuctionType]) {
          case FunctionType.on_Delete:
            _imagePathName = Constants.DELETE_ROOM_BTN_IMG_PATH;
            break;
          case FunctionType.on_Top:
            _imagePathName = Constants.TOP_ROOM_BTN_IMG_PATH;
            break;
          case FunctionType.on_Setting:
            _imagePathName = Constants.SETTING_ROOM_BTN_IMG_PATH;
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
        // onTap: widget.onTapped,
        onTap: (){
          if(_fuctionType != FunctionType.on_Setting.index) {
            widget.onTapped();
            return;
          }
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => SimpleDialog(
              title: Text('Add Accessor'),
              children: <Widget>[
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Constants.ACCESSOR_A_IMG_PATH))
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, getStringByAccessoryTypeEnum(AccessoryType.accessory_A)),
                ),
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Constants.ACCESSOR_B_IMG_PATH))
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, getStringByAccessoryTypeEnum(AccessoryType.accessory_B)),
                ),
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Constants.ACCESSOR_C_IMG_PATH))
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, getStringByAccessoryTypeEnum(AccessoryType.accessory_C)),
                ),
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Constants.ACCESSOR_D_IMG_PATH))
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, getStringByAccessoryTypeEnum(AccessoryType.accessory_D)),
                ),
                RaisedButton(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Constants.ACCESSOR_CLEAN_IMG_PATH))
                    ),
                  ),
                  onPressed: () => Navigator.pop(context, getStringByAccessoryTypeEnum(AccessoryType.non)),
                ),
              ],
            )
          ).then<String>((returnVal) {
            if(null != returnVal) {
              var type = getAccessoryTypeEnumByString(returnVal);
              widget.onTapped(type);
            }
          });
        },
        onPanUpdate: (tapInfo) {
          setState(() {
            print("Screen width: $width, height: $height");
            // xPosition += tapInfo.delta.dx;
            // yPosition += tapInfo.delta.dy;
          });
        },
        child: Container(
          width: _imageSize.dx,
          height: _imageSize.dy,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(_imagePathName), fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }

  String getStringByAccessoryTypeEnum(AccessoryType type) {
      switch (type) {
          case AccessoryType.accessory_A:
            return "Accessory_A";
            break;
          case AccessoryType.accessory_B:
            return "Accessory_B";
            break;
          case AccessoryType.accessory_C:
            return "Accessory_C";
            break;
          case AccessoryType.accessory_D:
            return "Accessory_D";
            break;
          case AccessoryType.non:
            return "Clear all";
            break;
          default:
        }
    }

    AccessoryType getAccessoryTypeEnumByString(String str) {
      switch (str) {
        case "Accessory_A":
            return AccessoryType.accessory_A;
            break;
        case "Accessory_B":
            return AccessoryType.accessory_B;
            break;
        case "Accessory_C":
            return AccessoryType.accessory_C;
            break;
        case "Accessory_D":
            return AccessoryType.accessory_D;
            break;
        case "Clear all":
            return AccessoryType.non;
            break;
        default:
      }
    }

}