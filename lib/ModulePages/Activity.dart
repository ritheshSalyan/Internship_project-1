import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import '../ModulePages/Discussion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {


  Widget categoryOne(BuildContext context) => TextFormField(
        obscureText: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: Colors.green,
          ),
          hintText: "ABZ startup",
          labelText: "Category 1",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );

  Widget categoryTwo(BuildContext context) => TextFormField(
        obscureText: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: Colors.green,
          ),
          hintText: "ABZ startup",
          labelText: "Category 2",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );

  Widget categoryThree(BuildContext context) => TextFormField(
        obscureText: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: Colors.green,
          ),
          hintText: "ABZ startup",
          labelText: "Category 3",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );

  Widget categoryFour(BuildContext context) => TextFormField(
        obscureText: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: Colors.green,
          ),
          hintText: "ABZ startup",
          labelText: "Category 4",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );

  Widget categoryFive(BuildContext context) => TextFormField(
        obscureText: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: Colors.green,
          ),
          hintText: "ABZ startup",
          labelText: "Category 5",
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      );

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
                                  "Now time for a quick Google search; give at least five categories of startups by their type (hint – you can search for the categories from different startup award contests): ",
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
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Please fill it",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  categoryOne(context),
                                  categoryTwo(context),
                                  categoryThree(context),
                                  categoryFour(context),
                                  categoryFive(context),
                                  SizedBox(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  OutlineButton(
                                    splashColor: Colors.green,
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                      width: 1.5,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context)=>DiscussionPage(),
                                        ),
                                      );
                                    },
                                    textColor: Colors.green,
                                    highlightedBorderColor: Colors.green,
                                    child: Text("Let's discuss"),
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ],
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
