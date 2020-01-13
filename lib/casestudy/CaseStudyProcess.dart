import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import '../ModuleOrderController/Types.dart';

class IntroScreen_Liquid extends StatefulWidget {
  IntroScreen_Liquid({Key key, this.dialogue, this.modNum, this.index})
      : super(key: key);
  final List<String> dialogue;
  int modNum, index;

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen_Liquid> {
  List<Container> pages = [];

  @override
  void initState() {
    create_slides();
    // Analytics.analyticsBehaviour("Case_Study_Page", "Case_Study");
  }

  void create_slides() {
    List<String> list = widget.dialogue;
    for (int i = 0; i < list.length; i++) {
      String item = list[i];
      if (i == list.length - 1) {
        // print("end i = $i");
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.fitHeight,
                  // width: 200,
                  height: 350,
                ),
                new RaisedButton(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    List<dynamic> arguments = [widget.modNum, widget.index];
                    orderManagement.moveNextIndex(context, arguments);
                  },
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ));
      } else if (i % 2 == 1) {
        // print("odd i = $i");
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.greenAccent,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.fitHeight,
                  // width: 200,
                  height: 350,
                ),
              ],
            ),
          ),
        ));
      } else if (i % 2 == 0) {
        // print("even i = $i");
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.fitHeight,
                  // width: 200,
                  height: 350,
                ),
              ],
            ),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
         
        body: OfflineBuilder(
          connectivityBuilder:
              (context, ConnectivityResult connectivity, Widget child) {
            final connected = connectivity != ConnectivityResult.none;
            if (connected) {
              child = LiquidSwipe(
                pages: pages,
                fullTransitionValue: 350,
                enableSlideIcon: true,
              );
            }
            return child;
          },
          child: NoNetPage(),
        ),
      ),
    );
  }
}
