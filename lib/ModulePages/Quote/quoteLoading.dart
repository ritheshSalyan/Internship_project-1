import 'package:flutter/material.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quote.dart';

class QuoteLoading extends StatefulWidget {
  QuoteLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _QuoteLoading createState() => _QuoteLoading();
}

class _QuoteLoading extends State<QuoteLoading> {
  @override
  void initState() {

    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    getEventsFromFirestore(widget.modNum).then((title){
      print("Title is "+title.toString());
         Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Quote(modNum: widget.modNum,quote: title),
      ),
    );

    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              strokeWidth: 5,
              value: null,
              valueColor: new AlwaysStoppedAnimation(Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              color: Colors.transparent,
             child: Text(
                "Loading... Please Wait",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<List<String>> getEventsFromFirestore(int modNum) async {
      CollectionReference ref = Firestore.instance.collection('module');
QuerySnapshot eventsQuery = await ref
    .where("id", isEqualTo: modNum)
    .getDocuments();

//HashMap<String, overview> eventsHashMap = new HashMap<String, overview>();
List<String> title =[];
eventsQuery.documents.forEach((document) {
  print("Quote "+document.toString());

  for (var item in document["quote" ]) {
     title.add(item.toString());
  }
 
  
});
  return title;
  }
}
