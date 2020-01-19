import 'package:flutter/material.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
// import 'CaseStudyProcess.dart';
// import 'firebaseConnect.dart';
import 'package:startupreneur/saveProgress.dart';
import 'ModuleOverview.dart';

class ModuleOverviewLoading extends StatefulWidget {
  ModuleOverviewLoading({Key key, this.modNum}) : super(key: key);
  final int modNum;
  @override
  _ModuleOverviewLoading createState() => _ModuleOverviewLoading();
}

class _ModuleOverviewLoading extends State<ModuleOverviewLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SaveProgress.getEventsFromFirestore(widget.modNum).then((value) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => ModulePageIntro(
    //         modNum: widget.modNum,
    //         index: 0,
    //       ),
    //     ),
    //   );
    // });
    return FutureBuilder(
        future: SaveProgress.getEventsFromFirestore(widget.modNum),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ModulePageIntro(
              modNum: widget.modNum,
              index: 0,
            );
          }
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
        });
  }
}
