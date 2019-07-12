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
      // backgroundColor: Color.fromRGBO(52, 52, 52, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 150),
              ),
              Center(
                child: Text(
                  "WELCOME",
                  style: TextStyle(
                      // color: Colors.green,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
              ),
              FlareActor(
                'assets/animation/arrow.flr',
                animation: 'Arrow',
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
