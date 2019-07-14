import 'package:flutter/material.dart';
import 'package:startupreneur/timeline/data.dart';
import 'trial.dart';

class motivationalPage extends StatefulWidget {

 motivationalPage({Key key, this.value}) : super(key: key);
  final int value;
  @override
  _motivationalPageState createState() => _motivationalPageState();
}

class _motivationalPageState extends State<motivationalPage> {
  @override
  Widget build(BuildContext context) {
    final doodle = doodles[widget.value];
    return Scaffold(
      body: PageView(
        children: <Widget>[
         Container(
           child:Image.network(doodle.doodle)
         ),
          VideoApp()
        ],
      ),
    );
  }
}