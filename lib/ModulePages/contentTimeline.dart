import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class timeLineArea extends StatelessWidget {
  @override
  
   Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
    ];
    return Container(
      child: PageView(
        children: pages,
      ),
    );
  }
  timelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: 5,
        lineColor: Colors.green,
        // physics: position == TimelinePosition.Left
        //     ? ClampingScrollPhysics()
        //     : BouncingScrollPhysics(),
        position: position,
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final textTheme = Theme.of(context).textTheme;
    return TimelineModel(
        new GestureDetector(
          onTap: () {
            print("Hello saaman $i");
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
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
                  Text("Text 1", style: textTheme.caption),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Text 2",
                    style:TextStyle(
                       fontSize: 12
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == 5,
        iconBackground: Colors.green,
        icon: Icon(Icons.navigation));
  }
}