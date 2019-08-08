import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddChatBoardRoom extends StatefulWidget {
  @override
  _AddChatBoardRoomState createState() => _AddChatBoardRoomState();
}

class _AddChatBoardRoomState extends State<AddChatBoardRoom> {
  String tags = "";
  String text  = "";


  void validate(BuildContext context){
    print("text is $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add topic"),
      ),
      body: SingleChildScrollView(
        child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Card(
              elevation: 8.0,
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (value){
                      setState(() {
                        text = value;
                      });
                    },
                    onSubmitted: (value){
                      if(value == null){
                        return "Cannot be null";
                      }
                      return null;
                    },
                    maxLines: 3,
                    maxLength: 150,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.comment,
                        color: Colors.green,
                      ),
                      hintText: "Whats in your mind",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),
                      onPressed: () {
                        validate(context);
                      },
                      child: Row(
                        children: <Widget>[
//                        Icon(FontAwesomeIcons.comment),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Share thoughts",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Title(
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.tags,
                    size: 10,
                  ),
                  Text(
                    " Tags",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Card(
              elevation: 8.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ActionChip(
                        label: Text("Module 1"),
                        elevation: 5.0,
                        onPressed: () {
                          setState(() {
                            tags = "Module 1";
                            print(tags);
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 2"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 2";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 3"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 3";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 4"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 4";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 5"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 5";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 6"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 6";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 7"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 7";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 8"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 8";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 9"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 9";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 10"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 10";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 11"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 11";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      ActionChip(
                        elevation: 5.0,
                        label: Text("Module 12"),
                        onPressed: () {
                          setState(() {
                            tags = "Module 12";
                          });
                        },
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ActionChip(
                        elevation: 5.0,
                        label: Text("General"),
                        onPressed: () {},
                        labelStyle: TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
