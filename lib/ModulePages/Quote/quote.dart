import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ModuleOverview/ModuleOverviewLoading.dart';
import '../../ModuleOrderController/Types.dart';

class Quote extends StatefulWidget {
  Quote({Key key, this.modNum, this.quote}) : super(key: key);
  int modNum;
  List<String> quote;
  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  @override
  Widget build(BuildContext context) {
    String text = (widget.modNum==12)?"Oh Yes!":"Start";
    return PageView(
      children: <Widget>[
        Container(
          color: Colors.green,
          // alignment: Alignment.bottomRight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.black.withOpacity(0),
                      child: Text(
                        widget.quote[0],
                        style: TextStyle(
                          // fontStyle: FontStyle.italic,
                          letterSpacing: 1.5,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.black.withOpacity(0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03),
                        child: Text(
                          widget.quote[1],
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
               
              ],
            ),
          ),
           Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: MediaQuery.of(context).size.width * 0.64),
                  child: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Text(
                         text,
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 20,
                            color: Colors.white,
                            // fontWeight: FontWeight.w700
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(widget.modNum!=12){ 
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ModuleOverviewLoading(modNum: widget.modNum),
                          // builder: (context)=>Vocabulary(),
                        ),
                      );
                      }
                      else{
                        orderManagement.moveNextIndex(context,[12,24]);
                      }
                    },
                  ),
                )
            ],
          )
        ),
      ],
    );
  }
}
