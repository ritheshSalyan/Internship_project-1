import 'package:flutter/material.dart';

class Trial extends StatefulWidget {
  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
  List<String> simpleList = ["hello world. how are you. long time no see"];
  List<String> split=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  //  print(simpleList[0].split("."));
   
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
     simpleList[0].split("."); 
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            )),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    "This is the trail page",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/Images/bus-driver.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Card(
              elevation: 10.0,
              child:FlatButton(
                onPressed: (){
                for(String i in split){
                      print("value is $i");
                }
                },
                child: Text("Tap to continue"),
              )
            ),
            )
          ],
        ),
      ),
    );
  }
}
