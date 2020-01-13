import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/IntroPage/IntroPageController.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/timeline/MainRoadmapLoader.dart';

import 'Auth/signin.dart';

class homePage extends StatefulWidget {
  homePage({Key key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  static SharedPreferences sharedPreferences;
  void initState() {
    super.initState();
    print("inside homepage init");
  }

  Future<bool> firstLogin() async {
    print("inside login");
    // sharedPreferences = await SharedPreferences.getInstance();
    // try {
    //   var value = sharedPreferences.getString("UserId");
    //   print(value);
    //   if (value == null) {
    //     print(" log");
    //     return false;
    //   }
    //   // widget.analytics.setUserId(value);
    //   return true;
    // } catch (e) {
    //   print(e.toString());
    //   // return ;
    // }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //  firstLogin().then((s) {
    //   print("home page $s");
    //   if (s==true) {
    //     print("home hello");
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => RoadmapLoader(),
    //       ),
    //     );
    //   }
    //   else{
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => SigninPage(),
    //       ),
    //     );
    //   }
    // });
    return Scaffold(
      body: FutureBuilder(
        future: firstLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return RoadmapLoader();
            }
            return SigninPage();
          }
          return Center(
            child: Text("Loading"),
          );
        },
      ),
    );
//     return CustomeOffline(
//           onConnetivity: Scaffold(
//         body: Container(
//           child: CircularProgressIndicator(),
// //         width: double.infinity,
// //         height: double.infinity,
// //         child: Center(
// //             child: SingleChildScrollView(
// //           child: Column(
// //             children: <Widget>[
// //               Padding(
// //                 padding: EdgeInsets.only(top: 50),
// //               ),
// //               Container(
// //                   child: Image.asset(
// //                 "assets/Images/Capture.PNG",
// //                 width: MediaQuery.of(context).size.width,
// //                 height: 40,
// //               )),
// //               Padding(
// //                 padding: EdgeInsets.only(top: 120),
// //               ),
// //               ButtonTheme(
// // //                buttonColor: Colors.black,
// //                 minWidth: 300,
// //                 height: 50,
// //                 child: RaisedButton(
// //                   elevation: 5,
// //                   color: Colors.green,
// //                   onPressed: () {
// //                     Navigator.of(context).push(
// //                       MaterialPageRoute(
// //                         builder: (context) => new SigninPage(),
// //                       ),
// //                     );
// //                   },
// //                   child: Text("Sign in", style: TextStyle(color: Colors.black)),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                   ),
// //                   // borderSide: BorderSide(
// //                   //   width: 1.5,
// //                   //   color: Colors.green,
// //                   //   style: BorderStyle.solid,
// //                   // ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: EdgeInsets.only(top: 10),
// //               ),
// //               ButtonTheme(
// //                 minWidth: 300,
// //                 height: 50,
// //                 buttonColor: Color(0xffffffff),
// //                 child: RaisedButton(
// //                   elevation: 5,
// //                   color: Colors.green,
// //                   onPressed: () {
// //                     Navigator.of(context).push(MaterialPageRoute(
// //                         builder: (context) => new SignupPage()));
// //                   },
// //                   child: Text("Sign up", style: TextStyle(color: Colors.black)),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(50),
// //                   ),
// //                   // borderSide: BorderSide(
// //                   //   width: 1.5,
// //                   //    color: Colors.green,
// //                   //   style: BorderStyle.solid,
// //                   // ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               )
// //             ],
// //           ),
// //         )),
//         ),
//       ),
//     );
  }
}
