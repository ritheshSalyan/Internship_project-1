import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import '../Discussion/Discussion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../ModuleOrderController/Types.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key key,this.modNum,this.question,this.buttonTitle,this.index}):super(key:key);
  final int modNum,index;
  final String question,buttonTitle;
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Widget> formList(BuildContext context) {
    List<Widget> itemInside = [];
    itemInside.add(
      Center(
        child: Text(
          "Please fill it",
        ),
      ),
    );
    itemInside.add(
      SizedBox(
        height: 10,
        width: MediaQuery.of(context).size.width,
      ),
    );
    for (int i = 0; i < 4; i++) {
      itemInside.add(
        TextFormField(
          obscureText: false,
          keyboardType: TextInputType.text,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.building,
              color: Colors.green,
            ),
            hintText: "ABZ startup",
            labelText: "Category ${i + 1}",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
     itemInside.add(
      SizedBox(
        height: 20,
        width: MediaQuery.of(context).size.width,
      ),
    );
    itemInside.add(
      Container(
        width: MediaQuery.of(context).size.width*0.5,
        child: OutlineButton(
        splashColor: Colors.green,
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.5,
        ),
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => DiscussionPage(),
          //   ),
          // );
           List<dynamic> arguments = [widget.modNum,widget.index];
                                    orderManagement.moveNextIndex(context, arguments);
        },
        textColor: Colors.green,
        highlightedBorderColor: Colors.green,
        child: Text(widget.buttonTitle),
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      )
    );
    return itemInside;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.green),
                    height: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Card(
                              margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  widget.question,
                                  // "Now time for a quick Google search; give at least five categories of startups by their type (hint – you can search for the categories from different startup award contests): ",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Open Sans",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Form(
                              child: ListView(
                                shrinkWrap: true,
                                // children: <Widget>[
                                //   Center(
                                //     child: Text(
                                //       "Please fill it",
                                //     ),
                                //   ),
                                //   SizedBox(
                                //     height: 10,
                                //     width: MediaQuery.of(context).size.width,
                                //   ),

                                //   // categoryOne(context),
                                //   // categoryTwo(context),
                                //   // categoryThree(context),
                                //   // categoryFour(context),
                                //   // categoryFive(context),
                                //   SizedBox(
                                //     height: 20,
                                //     width: MediaQuery.of(context).size.width,
                                //   ),
                                //   OutlineButton(
                                //     splashColor: Colors.green,
                                //     borderSide: BorderSide(
                                //       color: Colors.green,
                                //       width: 1.5,
                                //     ),
                                //     onPressed: () {
                                //       Navigator.of(context).pushReplacement(
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               DiscussionPage(),
                                //         ),
                                //       );
                                //     },
                                //     textColor: Colors.green,
                                //     highlightedBorderColor: Colors.green,
                                //     child: Text("Let's discuss"),
                                //     shape: BeveledRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //     ),
                                //   ),
                                // ],
                                children: formList(context),
                              ),
                            ),
                          ],
                        ),
                      ),
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
