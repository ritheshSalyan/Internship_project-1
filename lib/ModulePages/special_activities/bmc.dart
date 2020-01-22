import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as Pdf;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as fs;
import 'package:shared_preferences/shared_preferences.dart';

class BusinessModelCanvas extends StatefulWidget {
  BusinessModelCanvas({Key key, this.title, this.index}) : super(key: key);

  final String title;
  final int index;
  @override
  _BusinessModelCanvasState createState() => _BusinessModelCanvasState();
}

class _BusinessModelCanvasState extends State<BusinessModelCanvas> {
  String keyPartners = "";
  String keyActivities = "";
  String keyResource = "";
  String costStructure = "";
  String revenueStream = "";
  String valueProposition = "";
  String customerRelationship = "";
  String customerSegment = "";
  String channels = "";
  SharedPreferences sharedPreferences;
  fs.Firestore firestore = fb.firestore();

  void sendDataToFirebase() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("userId");
    var data = {
      "Key Partners": keyPartners,
      "Key Activities": keyActivities,
      "Key Resources": keyResource,
      "Cost Structure": costStructure,
      "Revenue Stream": revenueStream,
      "Value Proposition": valueProposition,
      "Customer Relationship": customerRelationship,
      "Customer Segment": customerSegment,
      "Channels": channels,
      "userId": userId,
      "title": "Business Model Canvas",
      "index": widget.index,
    };
    await firestore.collection("userSubmissions").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Key Partners",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black)),
                                child: GestureDetector(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Key Partners",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      Card(
                                        child: (keyPartners != "")
                                            ? Text("$keyPartners")
                                            : Text("Who can help you leverage your business? You won’t be performing all key activities yourself, or own or key resources from the start yourself. Who will you need to work with to accomplish these key infrastructural points?",style: TextStyle(color: Colors.grey[50]),),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Stack(
                                            children: <Widget>[
                                              Text(""),
                                              TextFormField(
                                                initialValue: keyPartners,
                                                maxLines: 200,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your keypartners",
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    keyPartners = text;
                                                  });
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    setState(() {
                                                      // keyPartners = "data";
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Key Activities",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: GestureDetector(
                                child: Card(
                                  child: (keyActivities != "")
                                      ? Text("$keyActivities")
                                      : Text("What do you need to do to have your business perform well? What are the key activities that drive your business model? ",style: TextStyle(color: Colors.grey[50])),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Stack(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue: keyActivities,
                                              maxLines: 200,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter your Key Activities",
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  keyActivities = text;
                                                });
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RaisedButton(
                                                color: Colors.green,
                                                onPressed: () {
                                                  setState(() {
                                                    // keyPartners = "data";
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Submit"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Key Resources",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: GestureDetector(
                                child: Card(
                                  child: (keyResource != "")
                                      ? Text("$keyResource")
                                      : Text("Which assets are indispensable for your business? ",style: TextStyle(color: Colors.grey[50]),),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Stack(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue: keyResource,
                                              maxLines: 200,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter your Key Resources",
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  keyResource = text;
                                                });
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RaisedButton(
                                                color: Colors.green,
                                                onPressed: () {
                                                  setState(() {
                                                    // keyPartners = "data";
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Submit"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Cost Structure",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: GestureDetector(
                                child: Card(
                                  child: (costStructure != "")
                                      ? Text("$costStructure")
                                      : Text("What will the specific cost structure be for your business, how will the revenue and profits be divided and what will these funds be used for. ",style: TextStyle(color: Colors.grey[50],),)
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Stack(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue: costStructure,
                                              maxLines: 200,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter your Cost Structure",
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  costStructure = text;
                                                });
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RaisedButton(
                                                color: Colors.green,
                                                onPressed: () {
                                                  setState(() {
                                                    // keyPartners = "data";
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Submit"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Revenue Stream",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: GestureDetector(
                                child: Card(
                                  child: (revenueStream != "")
                                      ? Text("$revenueStream")
                                      : Text("How and through which pricing mechanisms is your business capturing value?",style: TextStyle(color: Colors.grey[50]),),
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: Stack(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue: revenueStream,
                                              maxLines: 200,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter your Revenue Stream",
                                              ),
                                              onChanged: (text) {
                                                setState(() {
                                                  revenueStream = text;
                                                });
                                              },
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: RaisedButton(
                                                color: Colors.green,
                                                onPressed: () {
                                                  setState(() {
                                                    // keyPartners = "data";
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Submit"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Value Proposition",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: GestureDetector(
                                  child: Card(
                                    child: (valueProposition != "")
                                        ? Text("$valueProposition")
                                        : Text("The products and services that create value for your customers, i.e. the product your business is selling. ",style: TextStyle(color: Colors.grey[50])),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Stack(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: valueProposition,
                                                maxLines: 200,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your Value Proposition",
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    valueProposition = text;
                                                  });
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    setState(() {
                                                      // keyPartners = "data";
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Customer RelationShip",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: GestureDetector(
                                  child: Card(
                                    child: (customerRelationship != "")
                                        ? Text("$customerRelationship")
                                        : Text("What kind of relationship are you establishing with your customer? Do you work closely with clients on a long-term basis, or are you looking for short-term transactional relationships",style: TextStyle(color: Colors.grey[50])),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Stack(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue:
                                                    customerRelationship,
                                                maxLines: 200,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your Customer Relationship",
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    customerRelationship = text;
                                                  });
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    setState(() {
                                                      // keyPartners = "data";
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Customer Segment",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: GestureDetector(
                                  child: Card(
                                    child: (customerSegment != "")
                                        ? Text("$customerSegment")
                                        : Text(
                                            "All the people or organisations for which you are creating value, including simple users and paying customers.",
                                            style: TextStyle(
                                                color: Colors.grey[50]),
                                          ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Stack(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: customerSegment,
                                                maxLines: 200,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your Customer Segment",
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    customerSegment = text;
                                                  });
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    setState(() {
                                                      // keyPartners = "data";
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Channels",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: GestureDetector(
                                  child: Card(
                                    child: (channels != "")
                                        ? Text("$channels")
                                        : Text("How do you interact with customers and deliver your value? Are you an online platform? B2B? B2C? etc. ",style: TextStyle(color: Colors.grey[50]),),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Stack(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: channels,
                                                maxLines: 200,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your Channels",
                                                ),
                                                onChanged: (text) {
                                                  setState(() {
                                                    channels = text;
                                                  });
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    setState(() {
                                                      // keyPartners = "data";
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {},
                            child: Text("Upload"),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: () {
                              if (keyActivities != "" &&
                                  keyPartners != "" &&
                                  keyResource != "" &&
                                  costStructure != "" &&
                                  revenueStream != "" &&
                                  valueProposition != "" &&
                                  customerRelationship != "" &&
                                  customerSegment != "" &&
                                  channels != "") {
                                sendDataToFirebase();
                              } else {
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Text("Please fill all the fields"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                RaisedButton(
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }
                            },
                            child: Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
