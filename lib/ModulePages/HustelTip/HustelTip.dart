import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';

class HustelTipPage extends StatefulWidget {
  HustelTipPage({
    Key key,
    this.modNum,
    this.title,
    this.index,
  }) : super(key: key);
  String title;
  int modNum, index;

  @override
  _HustelTipPageState createState() => _HustelTipPageState();
}

class _HustelTipPageState extends State<HustelTipPage>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  // Animation<double> animation;

  @override
  void initState() {
    super.initState();
    Analytics.analyticsBehaviour("Hustle_Tip_Page", "Hustle_Tip");
  }

  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeOffline(
      onConnetivity: Scaffold(
          // bottomSheet: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Text(
          //       "Page ${widget.index+1}/${Module.moduleLength}",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.green),
          //     ),
          //   ],
          // ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              bottom: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Page ${widget.index + 1}/${Module.moduleLength}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: Builder(
            builder: (context) {
              var padding2 = Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      widget.title,
                      // "hello",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.green,
                        // fontSize: 10,//30
                        fontWeight: FontWeight.bold,
                      ),
                      minFontSize: 12,
                      maxLines: 10,
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
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hustle Tip",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
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
                      ]),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12,
                      left: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Image.asset(
                      "assets/Images/HustelTip.jpg",
                      height: 150,
                      width: 150,
                    ),
                  ),
                  padding2,
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
          )),
    );
  }
}
