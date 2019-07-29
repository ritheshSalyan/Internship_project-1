import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../socialize/socialize.dart';
import '../../ModuleOrderController/Types.dart';

class DiscussionPage extends StatefulWidget {
  DiscussionPage(
      {Key key, this.content, this.button, this.modNum, this.title, this.index,this.image})
      : super(key: key);
  String content, button, title,image;
  int modNum, index;
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  String data;
  int item = 0;
  List<String> _listViewData = [
    // "Swipe Right / Left to remove",
    // "Swipe Right / Left to remove",
  ];
  _onSubmit() {
    setState(() {
      item;
      if (item < data.split(". ").length ) {
        // for (var item in ) {
          if(data.split(".")[item].length>3){ 
        _listViewData.add(data.split(".")[item]+".");
          }
        item++;
        // }

      }

// _listViewData.add(_textController.text);
    });
  }

  List<Widget> convertTolist() {
    List<Widget> list = [];
    list.addAll(_listViewData.map((data) {
      // return Dismissible(
      //   key: Key(data),
      //   child: ListTile(
      //     title: Text(data),
      //   ),
      // );
      return Card(
          elevation: 0,
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // letterSpacing: 1.1,
                    fontFamily: "sans-serif",
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ));
    }).toList());

    if (item < data.split(". ").length) {
      list.add(Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04),
          child: OutlineButton(
          borderSide: BorderSide(
            color: Colors.green
          ),
          onPressed: _onSubmit,
          child: Text(
            'Tap here to Continue',
            style: TextStyle(
              // letterSpacing: 1.5,
              fontFamily: "Open Sans",
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          color: Colors.white,
        ),
        )
      ));
    } else {
      list.add(Center(
        child: FlatButton(
          onPressed: () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context)=>SocializeTask(),
            //   )
            // );
            List<dynamic> arguments = [widget.modNum, widget.index + 1];
            orderManagement.moveNextIndex(context, arguments);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(widget.button,
                  style: TextStyle(fontWeight: FontWeight.w700)),
              Icon(Icons.navigate_next),
            ],
          ),
        ),
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    data = widget.content;
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: MediaQuery.of(context).size.width * 0.02),
                      child: Column(
                        children: <Widget>[
                          Text(
                            widget.title,
                            //"Startup or Job",
                            style: TextStyle(
                              fontFamily: "sans-serif",
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.18),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        widget.image,
                       // "assets/Images/photo.png",
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.75,
                        alignment: Alignment.center,
                      ),
                      Column(
                        // children: <Widget>[

                        //    Card(
                        //       clipBehavior: Clip.antiAliasWithSaveLayer,
                        //       child: Padding(
                        //         padding: EdgeInsets.all(10.0),
                        //         child: Text(
                        //           widget.content,
                        //           //"Those working in startups get jealous when they see their friends drawing a great salary and having a structured life, while, those who are in jobs are upset when they see their startup friends having the flexibility and autonomy to solve problems in their own way. You probably know the workplace basics of each – large companies have set hours and are stricter, while, startups have more flexibility but are more demanding.",
                        //           style: TextStyle(
                        //             fontSize: 18.0,
                        //             
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //       ),
                        //     ),

                        // ],
                        children: convertTolist(),
                      ),
                      // FlatButton(
                      //   onPressed: () {
                      //     // Navigator.of(context).pushReplacement(
                      //     //   MaterialPageRoute(
                      //     //     builder: (context)=>SocializeTask(),
                      //     //   )
                      //     // );
                      //     List<dynamic> arguments = [
                      //       widget.modNum,
                      //       widget.index+1
                      //     ];
                      //     orderManagement.moveNextIndex(context, arguments);
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: <Widget>[
                      //       Text(widget.button,
                      //           style: TextStyle(fontWeight: FontWeight.w700)),
                      //       Icon(Icons.navigate_next),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
