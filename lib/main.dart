import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import './zoomable_widget.dart';
import './add_zoomable_widget_dropdown.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Draggable Demo',
      theme: ThemeData(
        fontFamily: 'PressStart',
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  
  List<KeyValueModel> zoomableWidgets = [];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  void onAddZoomableWidget(RoomType type) {
      setState(() {
        if(type == RoomType.non) {
          zoomableWidgets.clear();
          return;
        }
        var uuid = new Uuid();
        String key = uuid.v4();
        print('onAdd key: $key');
        var element = KeyValueModel(key: key, value: ZoomableWidget(key, onDeleteZoomableWidget, onTopZoomableWidget, onSettingZoomableWidget, type));
        zoomableWidgets.add(element);
      });

      for(int i = 0; i < zoomableWidgets.length; i++) {
        print('onAdd ($i) ${zoomableWidgets[i].key}');
      }
  }

  // Future<dynamic> onDeleteZoomableWidget(String key) async{
  void onDeleteZoomableWidget(String key) {
    print('onDelete Tapped Item $key');

    // showAlertDialog:
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  (){Navigator.pop(context);},
    );
    Widget continueButton = FlatButton(
      child: Text("Delete it", style: TextStyle(color: Colors.redAccent),),
      onPressed:  (){
        doDeleteZoomableWidget(key);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Would you like to continue?\n"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<dynamic> doDeleteZoomableWidget(String key) async{
    List<KeyValueModel> tempWidgets = [];
    for(int i = 0; i < zoomableWidgets.length; i++) {
        tempWidgets.add(zoomableWidgets[i]);
    }
    setState(() {
      zoomableWidgets.clear();
    });
    
    await Future.delayed(Duration(milliseconds: 100));
    tempWidgets.removeWhere((item) => item.key == key);
    setState(() {
      for(int i = 0; i < tempWidgets.length; i++) {
        zoomableWidgets.add(tempWidgets[i]);
      }
    });

    /***此作法更易讀，但存在問題 */
      // setState(() {
      // zoomableWidgets.removeWhere((item) => item.key == key);
      // zoomableWidgets.removeWhere((item) {
      //   if(item.key == key) {
      //     print('onDelete remove item by key: ${item.key}');
      //     item.value = null;
      //     return true;
      //   }
      //   return false;
      // });
      // });
  }

  void onTopZoomableWidget(String key){
    print('onTopZoomableWidget $key Item Tapped');
    print('onTopZoomableWidget ${zoomableWidgets.length} Item Tapped');
    if(zoomableWidgets.isEmpty || zoomableWidgets.length == 1) return;
    doReorder(key);
  }

  void onSettingZoomableWidget(String key){
    print('onSettingZoomableWidget $key Item Tapped');
    print('onSettingZoomableWidget ${zoomableWidgets.length} Item Tapped');
    if(zoomableWidgets.isEmpty) return;
    
  }

  Future<dynamic> doReorder(String key) async {
    int flag = 0;
    for(int i = 0; i < zoomableWidgets.length; i++) {
      print('($i) ${zoomableWidgets[i].key}');
      if(zoomableWidgets[i].key == key) {
        flag = i;
      }
      if(flag == zoomableWidgets.length -1) return;
    }
      
    KeyValueModel tempKVM = zoomableWidgets[flag];
    doDeleteZoomableWidget(key);
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      print('setState, flag=$flag');
      // zoomableWidgets.removeAt(flag);
      zoomableWidgets.add(tempKVM);
    });
  }

  @override
  Widget build(BuildContext context) {

    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    AppBar appBar = AppBar(
      title: Text('Draggable Demo'),
    );

    return Scaffold(
        appBar: appBar,

        body: Container(
          child: Stack(
            children: zoomableWidgets.map((element) {return element.value;}).toList(),
          ),
        ),

        floatingActionButton: AddZoomableWidgetDropdown(onAddZoomableWidget),
        // floatingActionButton: AddAccessorWidgetDropdown(onAddZoomableWidget),

      );
  }
}


class KeyValueModel {
  String key;
  ZoomableWidget value;

  KeyValueModel({this.key, this.value});

  // String _getKey() {
  //   return this.key;
  // }
}