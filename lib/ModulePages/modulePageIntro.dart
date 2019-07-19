import 'package:flutter/material.dart';
import 'package:startupreneur/ModulePages/motiPage.dart';
import 'overviewContent.dart';

class ModulePageIntro extends StatefulWidget {
  @override
  _ModulePageIntroState createState() => _ModulePageIntroState();
}

class _ModulePageIntroState extends State<ModulePageIntro> {

  @override
  Widget build(BuildContext context) {
    FirebaseFetch.getEventsFromFirestore().then((module){

       Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => motivationalPage(module: module,),
          ),
        );
     
    }).catchError((e){
return Container();
    });
    //return Container();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 350,
            // backgroundColor: Theme.of(context).primaryColorDark,
            backgroundColor: Colors.black,
            pinned: true,
            title: Text(
              "Course Overview",
              style: TextStyle(color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/Images/idea.png",
                fit: BoxFit.fitWidth,
                // height: 100,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              // overView(),
              <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
               
                // Card(
                //   shape: BeveledRectangleBorder(
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: ExpansionTile(
                //     leading: Icon(Icons.looks_one),
                //     title: Text(
                //       "How to build an Idea for your start-up",
                //       style: TextStyle(color: Colors.green),
                //     ),
                //     children: <Widget>[
                //       Divider(
                //         color: Colors.green,
                //       ),
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //           "How are Ideas Generated",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //            "Learn,Learn,Learn",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //           "Market research",
                //           textAlign: TextAlign.left,
                //         ),
                //       )
                      
                //     ],
                //   ),
                // ),
                // Card(
                //   shape: BeveledRectangleBorder(
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: ExpansionTile(
                //     leading: Icon(Icons.looks_two),
                //     title: Text(
                //       "Paths to a business Idea",
                //       style: TextStyle(color: Colors.green),
                //     ),
                //     children: <Widget>[
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //           "Primary path to new business idea",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                      
                //     ],
                //   ),
                // ),
                // Card(
                //   shape: BeveledRectangleBorder(
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: ExpansionTile(
                //     leading: Icon(Icons.looks_3),
                //     title: Text(
                //       "Why do you want startup",
                //       style: TextStyle(color: Colors.green),
                //     ),
                //     children: <Widget>[
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //            "Why you want to start-up (Questioning Character)",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //            "Myths busted",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //       // Text(
                //       //   "Why you want to start-up (Questioning Character)",
                //       //   textAlign: TextAlign.left,
                //       // ),
                //       // Text(
                //       //   "Myths busted",
                //       //   textAlign: TextAlign.left,
                //       // ),
                //     ],
                //   ),
                // ),
                // Card(
                //   shape: BeveledRectangleBorder(
                //     borderRadius: BorderRadius.circular(15.0),
                //   ),
                //   child: ExpansionTile(
                //     leading: Icon(Icons.looks_4),
                //     title: Text(
                //       "Which is best for you",
                //       style: TextStyle(color: Colors.green),
                //     ),
                //     children: <Widget>[
                //       ListTile(
                //         leading: Icon(Icons.arrow_forward_ios,size:20,),
                //         title: Text(
                //            "What to avoid ?",
                //           textAlign: TextAlign.left,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
             ],
            ),
          ),
        ],
      ),
    );
  }

 
}
