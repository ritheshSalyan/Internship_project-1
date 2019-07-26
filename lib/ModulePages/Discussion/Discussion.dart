import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../ModulePages/socialize.dart';

class DiscussionPage extends StatefulWidget {
  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
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
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    height: 150,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                         top: MediaQuery.of(context).size.height * 0.1),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Startup or Job",
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
                      top: MediaQuery.of(context).size.width * 0.4),
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
                                  "Those working in startups get jealous when they see their friends drawing a great salary and having a structured life, while, those who are in jobs are upset when they see their startup friends having the flexibility and autonomy to solve problems in their own way. You probably know the workplace basics of each – large companies have set hours and are stricter, while, startups have more flexibility but are more demanding.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Open Sans",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context)=>SocializeTask(),
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Lets Socialize"),
                            Icon(Icons.navigate_next),
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
