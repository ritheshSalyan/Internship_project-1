import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../socialize/socialize.dart';
import '../../ModuleOrderController/Types.dart';

class DecisionGameTextPage extends StatefulWidget {
  DecisionGameTextPage(
      {Key key,
      this.content,
      this.button,
      this.modNum,
      this.title,
      this.index,
      this.image})
      : super(key: key);
  String content, button, title, image;
  int modNum, index;
  @override
  _DecisionGameTextPageState createState() => _DecisionGameTextPageState();
}

class _DecisionGameTextPageState extends State<DecisionGameTextPage> {
  String data;
  int item = 0;
  List<String> _listViewData = [
    // "Swipe Right / Left to remove",
    // "Swipe Right / Left to remove",
  ];
  _onSubmit() {
    setState(() {
      item;
      if (item <= data.split(". ").length) {
        print("data.split(" ").length = " +
            data.split(". ").length.toString() +
            data.split(". ").toString());
        // for (var item in ) {
        if (data.split(".")[item].length > 3) {
          _listViewData.add(data.split(". ")[item] + ".");
        }
        item++;

        // }

      }

// _listViewData.add(_textController.text);
    });
  }

 
  List<Widget> formList(BuildContext context) {
    List<Widget> itemInside = [];
    itemInside.add(
      Center(
          child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            widget.title,
            //"Startup or Job",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "sans-serif",
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      )),
    );
    itemInside.add(
      SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
      ),
    );
    // for (int i = 0; i < 4; i++) {
    itemInside.add(
    Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
      child:   TextFormField(
        
        minLines: 3,
        maxLength: 500,
        maxLines: 100,
        obscureText: false,
        keyboardType: TextInputType.text,
        // maxLines: 1,
        decoration: InputDecoration(
          // prefixIcon: Icon(
          //   FontAwesomeIcons.building,
          //   color: Colors.green,
          // ),
          hintText: "Your Decision",
          labelText: "Your Decision",
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
    )
    );
    // }
    itemInside.add(
      SizedBox(
        height: 20,
        width: MediaQuery.of(context).size.width,
      ),
    );
    itemInside.add(Container(
      width: MediaQuery.of(context).size.width * 0.5,
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
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                //answers[_answerIs],
                widget.content,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              duration: Duration(hours: 1),
              backgroundColor: Colors.green[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              action: SnackBarAction(
                textColor: Colors.white,
                label: "Ok",
                onPressed: () {
                  // homeScaffoldKey.currentState.hideCurrentSnackBar();
                  Scaffold.of(context).hideCurrentSnackBar();
                  List<dynamic> arguments = [widget.modNum, widget.index + 1];
                  orderManagement.moveNextIndex(context, arguments);
                },
              ),
            ),
          );
        },
        textColor: Colors.green,
        highlightedBorderColor: Colors.green,
        child: Text(widget.button),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ));
    return itemInside;
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
                        children: <Widget>[],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: formList(context),
                   
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