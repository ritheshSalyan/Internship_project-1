import 'package:flutter/material.dart';
import '../timeline/MainRoadmap.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => TimelinePage(),
                ),
              );
            },
            child: Row(
              children: <Widget>[
                Text(
                  "Done",
                ),
                Icon(
                  Icons.done,
                  color: Colors.green,
                )
              ],
            )),
      ),
    );
  }
}
