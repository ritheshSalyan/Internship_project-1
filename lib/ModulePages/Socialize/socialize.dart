import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/globalKeys.dart';
import '../../ModuleOrderController/Types.dart';

class SocializeTask extends StatefulWidget {
  SocializeTask({Key key, this.index, this.modNum}) : super(key: key);
  final int index, modNum;
  @override
  _SocializeTaskState createState() => _SocializeTaskState();
}

class _SocializeTaskState extends State<SocializeTask> {
  static final _formkey = GlobalKey<FormState>();
  var _job = false;
  var _startup = false;
  int index ;

  bool _validate() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  validateAndSubmit(BuildContext context) async {
    if (_validate()) {
      setState(() {
        _job = true;
        print(_job);
        Navigator.of(context).pop();
      });
    }
  }

  bool _validateStartup() {
    final form = _formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  validateAndSubmitStartup(BuildContext context) async {
    if (_validateStartup()) {
      setState(() {
        _startup = true;
        Navigator.of(context).pop();
      });
    }
  }

  Future<Widget> _jobPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: <Widget>[
                Container(
                  child: Form(
                    autovalidate: true,
                    key: _formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                          "Pros",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_one,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_two,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        Text(
                          "Cons",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_one,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_two,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.15,
                              MediaQuery.of(context).size.width * 0.05,
                              0,
                              0),
                          child: FlatButton(
                            onPressed: () {
                              validateAndSubmit(context);
                            },
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Text("Submit"),
                                  Icon(
                                    Icons.done_outline,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Widget> _startPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            content: Column(
              children: <Widget>[
                Container(
                  child: Form(
                    autovalidate: true,
                    key: _formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                          "Pros",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_one,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_two,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          autovalidate: true,
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        Text(
                          "Cons",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_one,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_two,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Cannot be empty" : null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.looks_3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.15,
                              MediaQuery.of(context).size.width * 0.05,
                              0,
                              0),
                          child: FlatButton(
                            onPressed: () {
                              validateAndSubmitStartup(context);
                            },
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Text("Submit"),
                                  Icon(
                                    Icons.done_outline,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     setState(() {
     index = widget.index; 
    });
  }
  @override
  Widget build(BuildContext context) {
   
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
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName("TimelinePage"));
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
                      height: 150,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Time to Socialize",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Speak to at least one person each in your network who is currently working in a job or doing their own startup and ask them about their experiences.\n\nShare the top 3 pros and cons of being in a job and starting up, here:",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                top: MediaQuery.of(context).size.width * 0.2,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: FlatButton(
                                  // color: Colors.green,
                                  onPressed: () {
                                    _jobPopUp(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text("Job"),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.green[600],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02,
                                top: MediaQuery.of(context).size.width * 0.2,
                              ),
                              child: Container(
                                child: FlatButton(
                                  // color: Colors.green,
                                  onPressed: () {
                                    _startPopUp(context);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text("Startup"),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.green[600],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            top: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: OutlineButton(
                            // color: Colors.green,
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                            onPressed: () {
                              if (_job && _startup) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text("Well Done ! Let's Move Ahead"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Future.delayed(Duration(seconds: 3)).then(
                                  (value) {
                                    // Navigator.of(context).pushReplacement(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => QuestionFinalPage(),
                                    //   ),
                                    // );
                                    List<dynamic> arguments = [
                                      widget.modNum,
                                      index+1
                                    ];
                                    orderManagement.moveNextIndex(
                                        context, arguments);
                                  },
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text(
                                        "Fill both pros and cons of 2 tasks"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Lets Move On",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  color: Colors.green[600],
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
