import 'package:flutter/material.dart';
import 'package:startupreneur/timeline/data.dart';

class videoPlayerPage extends StatefulWidget {

  videoPlayerPage({Key key,this.placeValue}):super(key:key);
  final int placeValue;

  @override
  _videoPlayerPageState createState() => _videoPlayerPageState();
}

class _videoPlayerPageState extends State<videoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    final doodle = doodles[widget.placeValue];
    return Scaffold(
      body:Column(
        
        children: <Widget>[
          Padding(
          padding: EdgeInsets.only(top:50),
        ),
          Container(
            child:Image.network(doodle.doodle),
          )
        ],
      )
    );
  }
}