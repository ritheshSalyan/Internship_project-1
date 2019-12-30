import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:startupreneur/VentureBuilder/TabUI/activityIntro.dart';

class ListActivities extends StatefulWidget {
  ListActivities(
      {Key key,
      this.modNum,
      this.modName,
      this.intro,
      this.headings,
      this.index})
      : super(key: key);
  int modNum, index;
  String modName;
  List intro, headings;
  @override
  _ListActivitiesState createState() => _ListActivitiesState();
}

class _ListActivitiesState extends State<ListActivities>
    with TickerProviderStateMixin {
  Future firestoreData;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    // firestoreData = getData();
    tabController = DefaultTabController.of(context);
    print(widget.intro.length);
  }

  // Future<List> getData() async {

  //   var result = await Firestore.instance
  //       .collection("activity")
  //       .where("module", isEqualTo: widget.modNum)
  //       .getDocuments();
  //   result.documents.forEach((docData) {
  //     docData.data['Page'].forEach((val) {
  //       pages.add(val);
  //     });
  //     docData.data['content'].forEach((val) {
  //       content.add(val);
  //     });
  //   });
  //   print(pages);
  //   return [pages, content];
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.intro.length,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                "${widget.modName}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: TabBar(
                tabs: List<Widget>.generate(
                  widget.intro.length,
                  (int index) {
                    return Tab(
                      icon: Icon(Icons.access_time),
                    );
                  },
                ),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black12,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.black,
              ),
            ),
            body: TabBarView(
              children: List<Widget>.generate(
                widget.intro.length,
                (int index) {
                  return ActivityIntro(
                    intro: widget.intro,
                    heading: widget.headings,
                    index: index,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // },
  // );
}
// }
