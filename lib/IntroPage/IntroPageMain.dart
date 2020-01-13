import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/Auth/signin.dart';
import '../Auth/signin.dart';

// class IntroPage extends StatefulWidget {
//   // IntroPage({Key key, }) : super(key: key);
//   // int modNum, index;
//   // List<Page> pages;
//   @override
//   IntroPageState createState() => new IntroPageState();
// }

// class IntroPageState extends State<IntroPage> {
class PageStarter1State extends StatefulWidget {
  PageStarter1State({Key key, this.con}) : super(key: key);

  BuildContext con;
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  static String third =
      "The Startupreneur is a platform for anyone wishing to explore and evaluate Entrepreneurship.\n\nWhether you want to startup right now or even after a few years. Whether you want to work with a startup or just learn about starting up, this one’s dedicated to you!.\n\nGet the opportunity to build your venture, work with startups or even get access to incubation and potential seed funding. All this and more, while you achieve your certificate to become a Startupreneur!";

  @override
  _PageStarter1StateState createState() => _PageStarter1StateState();
}

class _PageStarter1StateState extends State<PageStarter1State> {

  @override
  void initState() {

    super.initState();
    // Analytics.analyticsBehaviour("Introduction_Page", "Starting_Page");
  }



  final pages = [
    // List<Slide> slides = new List();

    // @override
    // void initState() {
    //   super.initState();

    //   slides.add(
    //     new Slide(
    //       title: " ",
    //       styleTitle: TextStyle(
    //           color: Color(0xffD02090),
    //           fontSize: 30.0,
    //           fontWeight: FontWeight.bold,
    //           fontFamily: 'RobotoMono'),
    //       description: " ",
    //       styleDescription: TextStyle(
    //           color: Color(0xffD02090),
    //           fontSize: 20.0,
    //           fontStyle: FontStyle.italic,
    //           fontFamily: 'Raleway'),
    //       pathImage: "assets/Images/log.png",
    //       colorBegin: Colors.white,
    //       colorEnd: Colors.white,
    //       directionColorBegin: Alignment.topRight,
    //       directionColorEnd: Alignment.bottomLeft,
    //     ),
    //   );
    //   slides.add(
    //     new Slide(
    //       title:
    //           "\n\n\n\n\n\n\n\"Entrepreneurship cannot be taught, but it can certainly be learnt\"",
    //       maxLineTitle: 15,
    //       styleTitle: TextStyle(
    //         // fontStyle: FontStyle.italic,
    //         letterSpacing: 1.5,
    //         fontSize: 25,
    //         color: Colors.white,
    //       ),
    //       description: "        -#TheStartupreneur",
    //       styleDescription: TextStyle(
    //           letterSpacing: 1.5,
    //           fontSize: 20,
    //           color: Colors.black,
    //           fontWeight: FontWeight.w700),

    //       //  pathImage: "assets/Images/log.png",
    //       colorBegin: Colors.green,
    //       colorEnd: Colors.green,
    //       directionColorBegin: Alignment.topRight,
    //       directionColorEnd: Alignment.bottomLeft,
    //     ),
    //   );

    //   slides.add(
    //     new Slide(
    //       title: third,
    //       maxLineTitle: 30,
    //       styleTitle: TextStyle(
    //         // fontStyle: FontStyle.italic,
    //         letterSpacing: 1.5,
    //         fontSize: 16,
    //         color: Colors.white,
    //       ),
    //       //  description: "        -#TheStartupreneur",
    //       //  styleDescription:
    //       //      TextStyle(
    //       //               letterSpacing: 1.5,
    //       //               fontSize: 20,
    //       //               color: Colors.black,
    //       //               fontWeight: FontWeight.w700),

    //       pathImage: "assets/Images/introIcon.png",
    //       colorBegin: Colors.green,
    //       colorEnd: Colors.green,
    //       directionColorBegin: Alignment.topRight,
    //       directionColorEnd: Alignment.bottomLeft,
    //     ),
    //   );
    // }
    PageViewModel(
      pageColor: Colors.white,
      // iconImageAssetPath: 'assets/air-hostess.png',
      // bubble: Image.asset(
      //   'assets/Images/air-hostess.png',
      // ),
      bubbleBackgroundColor: Colors.green[200],
      body: Text(
        ' ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      title: Text(
        '',
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/Images/log.png',
        height: 300.0,
        // width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      bubbleBackgroundColor: Colors.green[200],
      pageColor: Colors.green,
      // iconImageAssetPath: 'assets/Images/waiter.png',
      body: Text(
        ' ',
      ),
      title: Text(
        ' ',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      mainImage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Material(
              color: Colors.black.withOpacity(0),
              child: Text(
                "\"Entrepreneurship cannot be taught, but it can certainly be learnt\"",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.black.withOpacity(0),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                " -#TheStartupreneur",
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      bubbleBackgroundColor: Colors.green[200],
      pageColor: Colors.green,
      // iconImageAssetPath: 'assets/Images/taxi-driver.png',
      title: Padding(
        padding: EdgeInsets.only(top: 0),
        child: Text(
          " ",
          style: TextStyle(
            fontSize: 1,
            color: Colors.white,
          ),
        ),
      ),
      body: Material(
        color: Colors.black.withOpacity(0),
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Image.asset(
            "assets/Images/introIcon.png",
            height: 150,
          ),
        ),
      ),
      mainImage: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          AutoSizeText(
            "The Startupreneur is a platform for anyone wishing to explore and evaluate Entrepreneurship.\n\nWhether you want to startup right now or even after a few years. Whether you want to work with a startup or just learn about starting up, this one’s dedicated to you!\n\nGet the opportunity to build your venture, work with startups or even get access to incubation and potential seed funding. All this and more, while you achieve your certificate to become a Startupreneur!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              // fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
              // fontSize: 16,
              color: Colors.white,
            ),
            maxLines: 20,
            minFontSize: 10,
          ),
          // Material(
          //   color: Colors.black.withOpacity(0),
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 10),
          //     child:Image.asset("assets/Images/introIcon.png",
          //     height: 220,
          //     ),
          //   ),
          // ),
        ],
      ),
      textStyle: TextStyle(
        color: Colors.green,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    //   return new IntroSlider(
    //     slides: this.slides,

    //     onDonePress: () {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => SigninPage(),
    //         ), //MaterialPageRoute
    //       );
    //     }, //this.onDonePress,
    //     // renderDoneBtn: this.renderDoneBtn(),
    //     nameDoneBtn: "Start",
    //     colorDoneBtn: Color(0x33000000),
    //     renderNextBtn: this.renderNextBtn(),
    //     // colorNextBtn: Color(0x33000000),
    //     renderSkipBtn: this.renderSkipBtn(),
    //     sizeDot: 20,
    //   );
    // }
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SigninPage(),
              ), //MaterialPageRoute
            );
          },
          // fullTransition:,
          doneText: Text("Let's Start!"),
          skipText: Text(" "),
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

/// Home Page of our example app.

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ), //Appbar
//       body: Center(
//         child: Text("This is the home page of the app"),
//       ), //Center
//     ); //Scaffold
//   }
// }
