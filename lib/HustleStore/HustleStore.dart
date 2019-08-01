import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'ServerData.dart';
import 'FullScreenDialog.dart';
import 'DataListing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HustleStore extends StatefulWidget {
  HustleStore({Key key, this.points, this.overall}) : super(key: key);
  int overall;
  dynamic points;
  @override
  _HustleStoreState createState() => _HustleStoreState();
}

class _HustleStoreState extends State<HustleStore> {
  Firestore db = Firestore.instance;
  dynamic j;
  SharedPreferences sharedPreferences;
  String userId;
  int i = itemList.length;
  double width, height;

  @override
  initState() {
    super.initState();
    sharedPrefereneData();
  }

  Future<void> sharedPrefereneData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
    // print("UserId  = $userId");
    await db
        .collection("user")
        .where("uid", isEqualTo: userId)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        setState(() {
          widget.points = value["points"];
        });
      });
    });
  }

  // Widget _buildCategoryItem(BuildContext context, int index) {
  //   final component = itemList[index];
  //   return MaterialButton(
  //     elevation: 1.0,
  //     highlightElevation: 1.0,
  //     onPressed: () {},
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     color: Colors.grey.shade800,
  //     textColor: Colors.white70,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           child: Image.asset(
  //             component.logo,
  //             fit: BoxFit.contain,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCategoryItem2(BuildContext context, int index) {
    final component = itemList[index];
    print(component.logo);
    return GestureDetector(
      onTap: () {
        print("You tapped $index");
        setState(() {
          if (widget.points >= component.price) {
            widget.points = widget.points - component.price;
            var point = new Map<String, dynamic>();
            point["points"] = widget.points;
            db.collection("user").document(userId).setData(point, merge: true);
          } else {}
        });
      },
      child: Container(
          color: Colors.green,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                Image.network(
                  component.logo,
                  fit: BoxFit.fitHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width * 0.20),
                  child: Row(
                    children: <Widget>[
                      component.gemIcon,
                      Text(
                        ' ${component.price}',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: AutoSizeText(
                    component.description,
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width * 0.5;
    height = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hustle Store"),
        elevation: 0.0,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.solidGem,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              Text(
                "${widget.points}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
              ),
            ],
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: width / height,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, int index) {
                          final component = itemList[index];
                          print(component.logo);
                          return GestureDetector(
                            onTap: () {
                              print("You tapped $index");
                              setState(
                                () {
                                  if(component.decision){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>ListingData(title:component.description),)
                                    );
                                  }
                                  else {
                                    if (widget.points >= component.price) {
                                      Navigator.of(context).push(
                                        new MaterialPageRoute<Null>(
                                          builder: (BuildContext context) {
                                            return new AddEntryDialog(
                                              points: component.price,
                                              available: widget.points,
                                              descript: component.product,
                                              image: component.logo,
                                              title: component.description,
                                              userid: userId,
                                              decision: component.decision,
                                            );
                                          },
                                          fullscreenDialog: true,
                                        ),
                                      );
                                      print("hey ${component.decision}");
                                    }
                                    else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          elevation: 5.0,
                                          duration: Duration(seconds: 10),
                                          backgroundColor: Colors.green,
                                          content: Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height *
                                                0.5,
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/Images/air-hostess.png",
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width *
                                                      0.3,
                                                  height: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height *
                                                      0.1,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.02,
                                                  ),
                                                  child: AutoSizeText(
                                                    "Sorry! You do not have enough points to unlock this cool product.\n\nHead to 'Earn Points' to know more.\n\nKeep earning more points to Hustle!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                            },
                            child: Container(
                              color: Colors.green,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Image.network(
                                      component.logo,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12),
                                        child: Center(
                                          child: Row(
                                            children: <Widget>[
                                              component.gemIcon,
                                              Text(
                                                ' ${component.price}',
                                              ),
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.045),
                                      child: AutoSizeText(
                                        component.description,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: i,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
