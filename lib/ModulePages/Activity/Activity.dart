import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/globalKeys.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
import '../../ModuleOrderController/Types.dart';
import '../../saveProgress.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage(
      {Key key,
      this.modNum,
      this.question,
      this.buttonTitle,
      this.index,
      this.hint})
      : super(key: key);
  final int modNum, index;
  final String question, buttonTitle, hint;
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  static final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Analytics.analyticsBehaviour("Category_Activity", "Category");
  }

  List<Widget> formList(BuildContext context) {
    List<Widget> itemInside = [];
    itemInside.add(
      Center(
        child: Text(
          "Please fill it",
        ),
      ),
    );
    itemInside.add(
      SizedBox(
        height: 10,
        width: MediaQuery.of(context).size.width,
      ),
    );
    for (int i = 0; i < 4; i++) {
      itemInside.add(
        TextFormField(
          validator: (value) => value.isEmpty ? "Cannot be empty" : null,
          autovalidate: true,
          obscureText: false,
          keyboardType: TextInputType.text,
          maxLines: 1,
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.building,
              color: Colors.green,
            ),
            hintText: "ABZ startup",
            labelText: "${widget.hint} ${i + 1}",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    itemInside.add(
      SizedBox(
        height: 20,
        width: MediaQuery.of(context).size.width,
      ),
    );
    itemInside.add(Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: OutlineButton(
        splashColor: Colors.green,
        borderSide: BorderSide(
          color: Colors.green,
          width: 1.5,
        ),
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => DiscussionPage(),
          //   ),
          // );
          // List<dynamic> arguments = [widget.modNum, widget.index];
          // orderManagement.moveNextIndex(context, arguments);
          traverse.navigate();
        },
        textColor: Colors.green,
        highlightedBorderColor: Colors.green,
        child: Text(widget.buttonTitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ));
    return itemInside;
  }

  ModuleTraverse traverse;
  @override
  Widget build(BuildContext context) {
    traverse = Provider.of<ModuleTraverse>(context);
    return OfflineBuilder(
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                bottom: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Page ${widget.index + 1}/${Module.moduleLength}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              traverse.navigateBack();
            },
          ),
              elevation: 0,
              actions: <Widget>[
                GestureDetector(
                  child: Icon(Icons.home),
                  onTap: () {
                    showDialog<bool>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            content: Text(
                                "Are you sure you want to return to Home Page? "),
                            title: Text(
                              "Warning!",
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                                  // SaveProgress.preferences(
                                  //     widget.modNum, widget.index);
                                  // Navigator.of(context).popUntil(
                                  //     ModalRoute.withName("TimelinePage"));
                                   Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => TimelinePage()),
                            );
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  return Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: WaveClipperOne(),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.green),
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Card(
                                    margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                                    clipBehavior: Clip.antiAlias,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        widget.question,
                                        // "Now time for a quick Google search; give at least five categories of startups by their type (hint – you can search for the categories from different startup award contests): ",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Card(
                              child: Column(
                                children: <Widget>[
                                  Form(
                                    autovalidate: true,
                                    key: _formkey,
                                    child: ListView(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: formList(context),
                                    ),
                                  ),
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
        return child;
      },
      child: NoNetPage(),
    );
  }
}
