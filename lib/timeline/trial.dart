import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'data.dart';
import 'package:startupreneur/Auth/signin.dart';
import 'package:startupreneur/ModulePages/trial.dart';

class TimelinePage extends StatefulWidget {
  TimelinePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Center),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pop(
                MaterialPageRoute(builder: (context)=>SigninPage()));
          },
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
       elevation: 0.0,
      ),
      body: PageView(
        children: pages,
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: doodles.length,
        lineColor: Colors.green,
        // physics: position == TimelinePosition.Left
        //     ? ClampingScrollPhysics()
        //     : BouncingScrollPhysics(),
        position: position,
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodles[i];
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        new GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>VideoApp())
            );
          },
          child: Stack(
            children: <Widget>[
              Card(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(0.0),
                // ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Image.network(doodle.doodle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(doodle.time, style: textTheme.caption),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        doodle.name,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
//              Container(
//                child: Opacity(
//                  opacity: 0.5,
//                  child: Image.asset(
//                    "assets/Images/logo1.png",
//                    fit: BoxFit.fill,
//                    // color: Colors.white.withOpacity(0.5),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodles.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }
}
