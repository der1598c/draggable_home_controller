  import 'package:flutter/material.dart';

  import './constants.dart' as Constants;
  import './zoomable_widget.dart';
  
  class AddZoomableWidgetDropdown extends StatefulWidget {
    
    Function onTappedItemToAdd;
    AddZoomableWidgetDropdown(this.onTappedItemToAdd);

    @override
    _AddZoomableWidgetDropdownState createState() {
      return _AddZoomableWidgetDropdownState();
    }
  }
  
  class _AddZoomableWidgetDropdownState extends State<AddZoomableWidgetDropdown> {
    String _value;
  
    @override
    Widget build(BuildContext context) {
      return Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              // child: Text(getStringByRoomypeEnum(RoomType.livingRoom)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Constants.LIVING_ROOM_IMG_PATH))
                ),
              ),
              value: getStringByRoomTypeEnum(RoomType.livingRoom),
            ),
            DropdownMenuItem<String>(
              // child: Text(getStringByRoomypeEnum(RoomType.bedroom)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Constants.BEDROOM_IMG_PATH))
                ),
              ),
              value: getStringByRoomTypeEnum(RoomType.bedroom),
            ),
            DropdownMenuItem<String>(
              // child: Text(getStringByRoomypeEnum(RoomType.bathroom)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Constants.BATHROOM_IMG_PATH))
                ),
              ),
              value: getStringByRoomTypeEnum(RoomType.bathroom),
            ),
            DropdownMenuItem<String>(
              // child: Text(getStringByRoomypeEnum(RoomType.kitchen)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Constants.KITCHEN_IMG_PATH))
                ),
              ),
              value: getStringByRoomTypeEnum(RoomType.kitchen),
            ),
            DropdownMenuItem<String>(
              // child: Text(getStringByRoomypeEnum(RoomType.gameRoom)),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Constants.GAME_ROOM_IMG_PATH))
                ),
              ),
              value: getStringByRoomTypeEnum(RoomType.gameRoom),
            ),
            DropdownMenuItem<String>(
              child: Text(getStringByRoomTypeEnum(RoomType.non)),
              value: getStringByRoomTypeEnum(RoomType.non),
            )
          ],
          onChanged: (String value) {
            // setState(() {
              // _value = value;
            // });
            RoomType type = getRoomTypeEnumByString(value);
            widget.onTappedItemToAdd(type);
          },
          // hint: Text('Select Item to add into screen.'),
          hint: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Constants.ADD_ROOM_BTN_IMG_PATH))
          ),
          ),
          value: _value,
        ),
      );
    }

    String getStringByRoomTypeEnum(RoomType type) {
      switch (type) {
          case RoomType.livingRoom:
            return "Living Room";
            break;
          case RoomType.bedroom:
            return "Bedroom";
            break;
          case RoomType.bathroom:
            return "Bathroom";
            break;
          case RoomType.kitchen:
            return "Kitchen";
            break;
          case RoomType.gameRoom:
            return "Game Room";
            break;
          case RoomType.non:
            return "Clear all";
            break;
          default:
        }
    }

    RoomType getRoomTypeEnumByString(String str) {
      switch (str) {
        case "Living Room":
            return RoomType.livingRoom;
            break;
        case "Bedroom":
            return RoomType.bedroom;
            break;
        case "Bathroom":
            return RoomType.bathroom;
            break;
        case "Kitchen":
            return RoomType.kitchen;
            break;
        case "Game Room":
            return RoomType.gameRoom;
            break;
        case "Clear all":
            return RoomType.non;
            break;
        default:
      }
    }

  }