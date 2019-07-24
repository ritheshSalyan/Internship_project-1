import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import '../ModulePages/Activity.dart';

class IntroScreen_Liquid extends StatefulWidget {
  IntroScreen_Liquid({Key key, this.dialogue}) : super(key: key);
  final List<String> dialogue;

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen_Liquid> {
  List<Container> pages = [];

  @override
  void initState() {
    create_slides();
  }

  void create_slides() {
    int i = 3;
    List<String> list = widget.dialogue;
    for (int i = 0; i < list.length; i++) {
      String item = list[i];
      if (i % 2 == 0) {
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 400,
                ),
              ],
            ),
          ),
        ));
      }
      if (i % 2 == 1) {
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.greenAccent,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 400,
                ),
              ],
            ),
          ),
        ));
      }
      if (i == list.length - 1) {
        pages.add(Container(
          alignment: Alignment.center,
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        item,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Open Sans",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                      ),
                      )
                    ],
                  ),
                ),
                
             

              

                    Image.asset(
                  'assets/Images/character.png',
                  fit: BoxFit.cover,
                  width: 200,
                  height: 400,
                ),
                     new RaisedButton(child: Icon(Icons.done,
                      color: Colors.white,),
                        onPressed: (){

                              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ActivityPage(
                     
                    ),
                    
                  ),
                );
                        },

                        color: Colors.green,
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
            body: LiquidSwipe(
      pages: pages,
      fullTransitionValue: 500,
      enableSlideIcon: true,
    )));
  }
}
