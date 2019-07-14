import 'package:flutter/material.dart';
import 'package:startupreneur/Auth/signin.dart';
import 'package:startupreneur/Auth/signup.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Container(
                  child: Image.asset(
                "assets/Images/Capture.PNG",
                width: MediaQuery.of(context).size.width,
                height: 40,
              )),
              Padding(
                padding: EdgeInsets.only(top: 120),
              ),
              ButtonTheme(
//                buttonColor: Colors.black,
                minWidth: 300,
                height: 50,
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => new SigninPage(),
                      ),
                    );
                  },
                  child: Text("Sign in", style: TextStyle(color: Colors.black)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // borderSide: BorderSide(
                  //   width: 1.5,
                  //   color: Colors.green,
                  //   style: BorderStyle.solid,
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              ButtonTheme(
                minWidth: 300,
                height: 50,
                buttonColor: Color(0xffffffff),
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.green,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new SignupPage()));
                  },
                  child: Text("Sign up", style: TextStyle(color: Colors.black)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  // borderSide: BorderSide(
                  //   width: 1.5,
                  //    color: Colors.green,
                  //   style: BorderStyle.solid,
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        )),
      ),
    );
  }
}
