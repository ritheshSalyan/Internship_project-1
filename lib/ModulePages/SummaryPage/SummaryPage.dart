import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    // TODO: implement initState
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: ColorizeAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      text: [
                        "Congratulations on completing Module 1",
                      ],
                      textStyle: TextStyle(
                        fontSize: 22.0,
                      ),
                      colors: [
                        Colors.purple,
                        Colors.blue,
                        Colors.yellow,
                        Colors.red,
                      ],
                      textAlign: TextAlign.center,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Baseline(
                    baseline: animation.value,
                    baselineType: TextBaseline.ideographic,
                    child: Image.asset(
                      "assets/Images/coins.png",
                      height: 100,
                      width: 100,
                    ),
                    // child: FlutterLogo(size: 50,),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
