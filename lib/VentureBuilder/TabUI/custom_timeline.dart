
import 'package:flutter/material.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
class CustomTimeLine extends StatelessWidget {
  CustomTimeLine({
    Key key,
    @required this.builder,
    @required this.itemCount,
    this.direction = Axis.vertical,
    this.completeIndex = -1,
  }) : super(key: key);
 final int itemCount; 
 final int completeIndex;
 final IndexedWidgetBuilder  builder;
  Size size;
 final Axis direction;
  @override
  Widget build(BuildContext context) {
    if(itemCount<completeIndex){
        throw "Completed index cannot be greater than total item count";
    }
    size = MediaQuery.of(context).size;
    bool isHorizontal = direction == Axis.horizontal;
    return ListView.builder(
      itemCount:itemCount, 
      shrinkWrap: true,
      scrollDirection: direction,
      itemBuilder: (context, i) {
        Widget body = builder(context,i);
          return isHorizontal? getHorizontal(i,body): getVertical(i, body) ;

                },
              );
            }
          
            Color getColor(bool isComplete) {
              return isComplete ? Colors.green : Colors.grey;
            }
          
            Widget timelineRowHorizontal(
                {@required Widget body, bool isComplete = false, double begin = 0.99}) {
              return TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween<double>(begin: begin, end: 1.0),
                builder: (context, data, child) {
                  Size size = MediaQuery.of(context).size;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.025,
                            height: size.width * 0.025,
                            decoration: new BoxDecoration(
                              color: getColor(isComplete),
                              shape: BoxShape.circle,
                            ),
                            child: Text(""),
                          ),
                          Container(
                            height: size.width * 0.005,
                            width: size.width * 0.1 * data,
                            decoration: new BoxDecoration(
                              color: getColor(isComplete),
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(""),
                          ),
                          Container(
                            height: size.width * 0.005,
                            width: size.width * 0.1 * (1 - data),
                            decoration: new BoxDecoration(
                              color: getColor(!isComplete),
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(""),
                          ),
                        ],
                      ),
                      Container(
                        child: body,
                      ),
                    ],
                  );
                },
              );
            }
          
            Widget timelineLastRowHorizontal(
                {@required Widget body, bool isComplete = false, double begin = 0.99}) {
              return TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween<double>(begin: begin, end: 1.0),
                builder: (context, data, child) {
                  Size size = MediaQuery.of(context).size;
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.025,
                            height: size.width * 0.025,
                            decoration: new BoxDecoration(
                              color: getColor(isComplete),
                              shape: BoxShape.circle,
                            ),
                            child: Text(""),
                          ),
          
                           Container(
                            height: size.width * 0.005,
                            width: size.width * 0.1 ,
                            decoration: new BoxDecoration(
                              color:Colors.transparent,
                              shape: BoxShape.rectangle,
                            ),
                            child: Text(""),
                          ),
                        
                        ],
                      ),
                      Container(
                        child: body,
                      ),
                    ],
                  );
                },
              );
            }
          
            Widget timelineRowVertical(
                {@required Widget body, bool isComplete = false, double begin = 0.99}) {
              return TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween<double>(begin: begin, end: 1.0),
                builder: (context, data, child) {
                  Size size = MediaQuery.of(context).size;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.025,
                              height: size.width * 0.025,
                              decoration: new BoxDecoration(
                                color: getColor(isComplete),
                                shape: BoxShape.circle,
                              ),
                              child: Text(""),
                            ),
                            Container(
                              width: size.width * 0.005,
                              height: size.height * 0.1 * data,
                              decoration: new BoxDecoration(
                                color: getColor(isComplete),
                                shape: BoxShape.rectangle,
                              ),
                              child: Text(""),
                            ),
                            Container(
                              width: size.width * 0.005,
                              height: size.height * 0.1 * (1 - data),
                              decoration: new BoxDecoration(
                                color: getColor(!isComplete),
                                shape: BoxShape.rectangle,
                              ),
                              child: Text(""),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          child: body,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          
            Widget timelineLastRowVertical(
                {@required Widget body, bool isComplete = false, double begin = 0.99}) {
              return TweenAnimationBuilder(
                duration: Duration(seconds: 1),
                tween: Tween<double>(begin: begin, end: 1.0),
                builder: (context, data, child) {
                  Size size = MediaQuery.of(context).size;
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.025,
                              height: size.width * 0.025,
                              decoration: new BoxDecoration(
                                color: getColor(isComplete),
                                shape: BoxShape.circle,
                              ),
                              child: Text(""),
                            ),
                              Container(
                              width: size.width * 0.025,
                              height: size.width * 0.1,
                              decoration: new BoxDecoration(
                                color:Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(""),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          child: body,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          
            Widget getVertical(int i,Widget body) {
                 return
            i == itemCount - 1
                ? timelineLastRowVertical( body: body,
                    isComplete: i <= completeIndex)
                :
            timelineRowVertical(
                body: body,
                isComplete: i <= completeIndex,
                begin: i == completeIndex ? 0 : 0.99);
            }

            Widget getHorizontal(int i,Widget body){
                 return
            i == itemCount - 1
                ? timelineLastRowHorizontal( body: body ,
                    isComplete: i <= completeIndex)
                :
            timelineRowHorizontal(
                body: body,
                isComplete: i <= completeIndex,
                begin: i == completeIndex ? 0 : 0.99);
            }
}
