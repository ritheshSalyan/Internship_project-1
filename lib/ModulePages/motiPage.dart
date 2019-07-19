import 'package:flutter/material.dart';
import 'overviewContent.dart';
import '../ModulePages/quiz/quiz_page.dart';

class motivationalPage extends StatefulWidget {
  motivationalPage({Key key, this.module,this.modNum}) : super(key: key);
  final List<overview> module;
  final int modNum;
  @override
  _motivationalPageState createState() => _motivationalPageState();
}

class _motivationalPageState extends State<motivationalPage> {
  @override
  Widget build(BuildContext context) {
    List<overview> module = widget.module;
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
              overView(module),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> overView(module) {
    List<Widget> widgetList = new List();
    widgetList.add(
      Padding(
        padding: EdgeInsets.only(top: 15),
      ),
    );

    for (overview over in module) {
      List<Widget> inner = new List();
      inner.add(
        Divider(
          color: Colors.green,
        ),
      );

      for (var outcome in over.content) {
        inner.add(
          ListTile(
            leading: Icon(
              Icons.done,
              size: 20,
            ),
            title: Text(
              outcome.toString(),
              textAlign: TextAlign.left,
            ),
          ),
        );
      }

      widgetList.add(
        Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ExpansionTile(
            leading: Icon(Icons.arrow_forward_ios),
            title: Text(
              over.headding,
              style: TextStyle(color: Colors.green),
            ),
            children: inner,
          ),
        ),
      );
    }

    //  widgetList.add(
    //          Card(
    //             shape: BeveledRectangleBorder(
    //               borderRadius: BorderRadius.circular(15.0),
    //             ),
    //             child: ExpansionTile(
    //               leading: Icon(Icons.looks_one),
    //               title: Text(
    //                 "How to build an Idea for your start-up",
    //                 style: TextStyle(color: Colors.green),
    //               ),
    //               children: <Widget>[
    //                 Divider(
    //                   color: Colors.green,
    //                 ),
    //                 ListTile(
    //                   leading: Icon(Icons.arrow_forward_ios,size:20,),
    //                   title: Text(
    //                     "How are Ideas Generated",
    //                     textAlign: TextAlign.left,
    //                   ),
    //                 ),
    //                 ListTile(
    //                   leading: Icon(Icons.arrow_forward_ios,size:20,),
    //                   title: Text(
    //                      "Learn,Learn,Learn",
    //                     textAlign: TextAlign.left,
    //                   ),
    //                 ),
    //                 ListTile(
    //                   leading: Icon(Icons.arrow_forward_ios,size:20,),
    //                   title: Text(
    //                     "Market research",
    //                     textAlign: TextAlign.left,
    //                   ),
    //                 )

    //               ],
    //             ),
    //           ),
    //   );
    return widgetList;
  }
}
