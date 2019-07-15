import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class PageStarter2 extends StatefulWidget {
  @override
  _PageStarter2State createState() => _PageStarter2State();
}

class _PageStarter2State extends State<PageStarter2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlareActor(
        'assets/animation/arrow.flr',
        animation: 'Arrow',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
