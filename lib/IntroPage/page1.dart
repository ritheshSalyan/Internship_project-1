import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';

class PageStarter1 extends StatefulWidget {
  @override
  _PageStarter1State createState() => _PageStarter1State();
}

class _PageStarter1State extends State<PageStarter1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 150),
              ),
              Text(
                "data",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
