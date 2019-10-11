import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
// import 'package:flare_splash_screen/flare_splash_screen.dart';
import '../../timeline/MainRoadmapLoader.dart';

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      body: FlareActor(
        "assets/animation/Cup3.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "cup",
        callback: (a){
            print("On success Animation");
             Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => RoadmapLoader(),
          ),
           ModalRoute.withName("TimelinePage")
        );
        },
      ),
    );
    // return SplashScreen(
    //   "assets/animation/Cup3.flr",
    //   HomeView(),
    //   startAnimation: "cup",
    //   backgroundColor: Color(0xff181818),
    //   onSuccess: (dynamic) {
    //     print("On success Animation");
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => RoadmapLoader(),
    //       ),
    //     );
    //   },
    // );
  }
}

// class HomeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff181818),
//       body: Center(
//         child: Text(
//           'Home View',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
