import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';
import '../../saveProgress.dart';

class DecisionGameTextPage extends StatefulWidget {
  DecisionGameTextPage(
      {Key key,
      this.content,
      this.button,
      this.modNum,
      this.title,
      this.index,
      this.image,this.id})
      : super(key: key);
  String content, button, title, image,id;
  int modNum, index;
  @override
  _DecisionGameTextPageState createState() => _DecisionGameTextPageState();
}

class _DecisionGameTextPageState extends State<DecisionGameTextPage> {
  String data;
  int item = 0;
  String documentId;
  // List<String> _listViewData = [
  //   // "Swipe Right / Left to remove",
  //   // "Swipe Right / Left to remove",
  // ];
  final _formkey = GlobalKey<FormState>();

  bool _validateForm() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void addToCollection() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("UserId");
    var uploadData = Map<String, dynamic>();
    uploadData['answer'] = data;
    // data['attempts'] = attempts;
    Firestore.instance
        .collection("decisionGameText")
        .document(widget.id)
        .collection("answers")
        .document(userId)
        .setData(uploadData);
  }

  bool validateDetail(BuildContext context) {
    if (_validateForm()) {
      return true;
    }
    return false;
  }
//   _onSubmit() {
//     setState(() {
//       item;
//       if (item <= data.split(". ").length) {
//         print("data.split(" ").length = " +
//             data.split(". ").length.toString() +
//             data.split(". ").toString());
//         // for (var item in ) {
//         if (data.split(".")[item].length > 3) {
//           _listViewData.add(data.split(". ")[item] + ".");
//         }
//         item++;

//         // }

//       }

// // _listViewData.add(_textController.text);
//     });
//   }

  List<Widget> formList(BuildContext context) {
    List<Widget> itemInside = [];
    itemInside.add(
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0),
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
        ),
      ),
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
        child: Form(
          key: _formkey,
          // autovalidate: true,
          child: TextFormField(
            validator: (value) => value.isEmpty ? "Cannot be empty" : null,
            onChanged: (value) {
              data = value;
            },
            // autovalidate: true,
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
        ),
      ),
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
          bool value = validateDetail(context);

          if (value) {
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
                    addToCollection();
                    // homeScaffoldKey.currentState.hideCurrentSnackBar();
                    Scaffold.of(context).hideCurrentSnackBar();
                    List<dynamic> arguments = [widget.modNum, widget.index + 1];
                    orderManagement.moveNextIndex(context, arguments);
                  },
                ),
              ),
            );
          }
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
    // data = widget.content;
    return CustomeOffline(
      onConnetivity: Scaffold(
         bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
               "${widget.index+1}/${Module.moduleLength}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
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
                              SaveProgress.preferences(
                                  widget.modNum, widget.index);
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName("TimelinePage"));
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
            ),
          ],
        ),
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
                      height: MediaQuery.of(context).size.height * 0.4,
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
      ),
    );
  }
}
