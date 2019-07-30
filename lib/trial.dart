import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Trial extends StatefulWidget {
  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {

  static const platform  = const MethodChannel("hello.world.hi");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: (){},
              child: Text("Click me to revel"),
            )
          ],
        ),
      ),
    );
  }
}
