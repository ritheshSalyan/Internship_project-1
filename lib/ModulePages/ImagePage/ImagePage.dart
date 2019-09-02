import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../ModuleOrderController/Types.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ImagePagePage extends StatefulWidget {
  ImagePagePage({
    Key key,
    this.modNum,
    this.title,
    this.index,
    this.headding,
  }) : super(key: key);
  String title,headding;
  int modNum, index;

  @override
  _ImagePagePageState createState() => _ImagePagePageState();
}

class _ImagePagePageState extends State<ImagePagePage>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Heading in ImagePage is "+widget.headding);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    // top: MediaQuery.of(context).size.height * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Text(
                    widget.headding,
                    //"Startup or Job",
                    style: TextStyle(
                        fontFamily: "sans-serif",
                        color: Colors.green,
                        fontSize: 25.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    // top: MediaQuery.of(context).size.height * 0.1,
                    // left: MediaQuery.of(context).size.height * 0.01,
                  ),
                  // child: Image.asset(
                  //   widget.title,
                  //   height: MediaQuery.of(context).size.height * 0.7,
                  // ),
                  child: ExtendedImage.asset(
                    widget.title,
                    height: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
               
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: OutlineButton(
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                      onPressed: () {
                        List<dynamic> arguments = [
                          widget.modNum,
                          widget.index + 1
                        ];
                        orderManagement.moveNextIndex(context, arguments);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Next",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Image.asset(
                          //   "assets/Images/coins.png",
                          //   height: 20,
                          //   width: 20,
                          // ),
                        ],
                      )),
                )
              ],
            );
          },
        ));
  }
}
