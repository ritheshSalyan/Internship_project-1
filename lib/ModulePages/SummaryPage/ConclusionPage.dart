import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'ani.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {

    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    animation = Tween(begin: -500.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeOffline(
          onConnetivity: Scaffold(
          backgroundColor: Colors.white,
          body: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center;
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      left: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Image.asset(
                      "assets/Images/summary1.jpg",
                      height: 150,
                      width: 150,
                    ),
                    // child: FlareActor('assets/arrow.flr', animation: 'activate'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Completed !",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "You have successfully completed this module!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.height * 0.1,
                      right: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: OutlineButton(
                        borderSide: BorderSide(color: Colors.green, width: 1.5),
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute(
                          //     builder: (context) => RoadmapLoader(),
                          //   ),
                          // );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage1(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Claim My Points ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              "assets/Images/coins.png",
                              height: 20,
                              width: 20,
                            ),
                          ],
                        )),
                  )
                ],
              );
            },
          )),
    );
  }
}
