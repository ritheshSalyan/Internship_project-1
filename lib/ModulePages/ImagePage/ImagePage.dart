import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import '../../ModuleOrderController/Types.dart';

class ImagePagePage extends StatefulWidget {
  ImagePagePage({
    Key key,
    this.modNum,
    this.title,
    this.index,
    this.headding,
  }) : super(key: key);
  String title, headding;
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
    super.initState();
  }

  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Heading in ImagePage is " + widget.headding);
    return CustomeOffline(

          onConnetivity: Scaffold(
          backgroundColor: Colors.white,
          body: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.009,
                      bottom: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.headding,
                          //"Startup or Job",
                          style: TextStyle(
                              fontFamily: "sans-serif",
                              color: Colors.green,
                              fontSize: 23.0,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          child: Icon(Icons.home),
                          onTap: () {
                            showDialog<bool>(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: Text(
                                        "Are you sure you want to return to Home Page? "),
                                    title: Text(
                                      "Warning!",
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                                          Navigator.of(context).popUntil(
                                              ModalRoute.withName(
                                                  "TimelinePage"));
                                        },
                                      ),
                                      FlatButton(
                                        child: Text(
                                          "No",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        )
                      ],
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
                    child: (widget.title.contains("assets/Images"))
                        ? ExtendedImage.asset(
                            widget.title,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.contain,
                            mode: ExtendedImageMode.Gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
                                animationMinScale: 0.7,
                                maxScale: 20.0,
                                animationMaxScale: 20.5,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: false,
                              );
                            },
                          )
                        : ExtendedImage.network(
                            widget.title,
                            height: MediaQuery.of(context).size.height * 0.6,
                            fit: BoxFit.contain,
                            mode: ExtendedImageMode.Gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
                                animationMinScale: 0.7,
                                maxScale: 20.0,
                                animationMaxScale: 20.5,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: false,
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      // top: MediaQuery.of(context).size.height * 0.05,
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
          )),
    );
  }
}
