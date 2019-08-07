import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TopicHeadingPage extends StatefulWidget {
   TopicHeadingPage(
      {Key key,
     
      this.modNum,
      this.title,
      this.index,
      })
      : super(key: key);
  String  title;
  int modNum,index;

  @override
  _TopicHeadingPageState createState() => _TopicHeadingPageState();
}

class _TopicHeadingPageState extends State<TopicHeadingPage>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = AnimationController(
    //     duration: Duration(milliseconds: 3000), vsync: this);
    // animation = Tween(begin: -500.0, end: 100.0).animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // _controller.forward();
  }

  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.2,
                //     left: MediaQuery.of(context).size.height * 0.02,
                //   ),
                //   child: Image.asset(
                //     "assets/Images/TopicHeading.PNG",
                //     height: 150,
                //     width: 150,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // Text(
                      //   "You have successfully completed this module :)",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //   ),
                      // ),
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
                    borderSide: BorderSide(color:Colors.green,width: 1.5),
                    onPressed: (){
  List<dynamic> arguments = [widget.modNum, widget.index + 1];
            orderManagement.moveNextIndex(context, arguments);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Next",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // Image.asset(
                        //   "assets/Images/coins.png",
                        //   height: 20,
                        //   width: 20,
                        // ),
                      ],
                    )
                  ),
                )
              ],
            );
          },
        ));
  }
}
