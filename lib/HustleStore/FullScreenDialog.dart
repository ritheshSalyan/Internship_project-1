import 'package:flutter/material.dart';
import 'HustleStore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HustleStoreLoader.dart';

class AddEntryDialog extends StatefulWidget {
  AddEntryDialog(
      {Key key,
      this.points,
      this.available,
      this.descript,
      this.image,
      this.title,
      this.userid,
      this.decision,})
      : super(key: key);
  int points;
  int available;
  String descript;
  String image;
  String title;
  String userid;
  bool decision;
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  Firestore db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
//        actions: [
//          new FlatButton(
//            onPressed: () {
//              widget.available = widget.available - widget.points;
//              print(widget.available);
//              Navigator.pop(context);
//            },
//            child: new Text(
//              'Yes',
//              style: Theme.of(context)
//                  .textTheme
//                  .subhead
//                  .copyWith(color: Colors.white),
//            ),
//          ),
//        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0000001),
              child: Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        widget.image,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Text(
                        widget.descript.replaceAll(".", ".\n\n"),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "* Please click on Claim Button to avail it for ${widget.points}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: (){
                          setState(() {
                            widget.available = widget.available - widget.points;
                            widget.decision = true;
                            var dataSet = Map<String, dynamic>();
                            dataSet["points"] = widget.available;
                            db.collection("user").document(widget.userid).setData(
                                dataSet,merge: true);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HustleStoreLoader()));
                            print("done");
                          });

                        },
                        child: Text("Claim it "),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
