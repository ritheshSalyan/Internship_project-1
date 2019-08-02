import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'ServerData.dart';
import 'FullScreenDialog.dart';
import 'DataListing.dart';
import 'incubation.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
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
  dynamic lengthVal;
  SharedPreferences sharedPreferences;
  String userId;
  int i = itemList.length;
  double width, height;
  List<Color> color = [
    Color.fromRGBO(222, 30, 89, 1),
    Color.fromRGBO(59, 40, 127, 1)
  ];

  @override
  initState() {
    super.initState();
    sharedPrefereneData();
    widget.points = 60000;
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
    await db
        .collection("user")
        .where("uid", isEqualTo: userId)
        .getDocuments()
        .then((document) {
      document.documents.forEach((value) {
        lengthVal = value.data["completed"];
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
                        style: TextStyle(
                          color: Colors.white,
                        ),
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

  Widget planetThumbnail(BuildContext context) => new Container(
//      height: MediaQuery.of(context).size.height * 0.3,
//    margin: new EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.1),
      alignment: FractionalOffset.centerLeft,
      child: CircleAvatar(
        backgroundColor: Colors.black,
        radius: 35,
        child: new Image(
          image: new AssetImage("assets/Images/air-hostess.png"),
          height: 50.0,
          width: 50.0,
        ),
      ));

  Widget planetCard(BuildContext context, int index, String description,
          Image gemIcon, int price, OutlineButton button) =>
      new Container(
//    color: Colors.black12,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: new EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02),
          decoration: new BoxDecoration(
            color: Colors.black12,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 30.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.card,
            color: Colors.grey[300],
            child: GradientCard(
//          shape: Border.all(width: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              gradient: LinearGradient(colors: color),
              elevation: 12.0,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: planetThumbnail(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04),
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: AutoSizeText(
                              "$description",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 4,
                              wrapWords: false,
                              group: AutoSizeGroup(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
//                    ),
                          Row(
                            children: <Widget>[
                              gemIcon,
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.05),
                              ),
                              Text(
                                ' $price',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
//                    button,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width * 0.5;
    height = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      backgroundColor: Colors.grey[300],
//      appBar: AppBar(
//        title: Text("Hustle Store"),
//        elevation: 0.0,
//        actions: <Widget>[
//          Row(
//            children: <Widget>[
//              IconButton(
//                onPressed: () {},
//                icon: Icon(
//                  FontAwesomeIcons.solidGem,
//                  color: Colors.white,
//                  size: 15,
//                ),
//              ),
//              Text(
//                "${widget.points}",
//                style:
//                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//              ),
//              Padding(
//                padding: EdgeInsets.only(right: 20),
//              ),
//            ],
//          )
//        ],
//      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
//
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    expandedHeight: MediaQuery.of(context).size.height * 0.05,
                    backgroundColor: Theme.of(context).primaryColor,
//                    backgroundColor: Colors.black,
                    pinned: true,
                    title: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Hustle Store",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/Images/coins.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                  AutoSizeText(
                                    "   ${widget.points}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
//                      background: Image.asset(
//                        "assets/Images/${widget.modNum}.png",
//                        fit: BoxFit.fitWidth,
//                      ),
                        ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 6 / 3,
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
                                  if (index == 1) {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Incubation(
                                        title: "Incubation",
                                      ),
                                    ));
                                  } else if (component.decision) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ListingData(
                                          title: component.description,
                                          index: index),
                                    ));
                                  } else {
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
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          elevation: 5.0,
                                          duration: Duration(seconds: 13),
                                          backgroundColor: Colors.green,
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/Images/error_idea.png",
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
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
//                              margin: const EdgeInsets.symmetric(
//                                vertical: 16.0,
//                                horizontal: 24.0,
//                              ),
                              child: new Stack(
                                children: <Widget>[
                                  planetCard(
                                    context,
                                    index,
                                    component.description,
                                    component.gemIcon,
                                    component.price,
                                    component.claimIt,
                                  ),
//                                  planetThumbnail(context),
                                ],
                              ),
                            ),
//                            child: Container(
//                              color: Colors.green,
//                              child: Card(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(20.0),
//                                ),
//                                child: Column(
//                                  children: <Widget>[
//                                    Image.network(
//                                      component.logo,
//                                      fit: BoxFit.fitHeight,
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(
//                                          top: MediaQuery.of(context)
//                                                  .size
//                                                  .height *
//                                              0.02,
//                                          left: MediaQuery.of(context)
//                                                  .size
//                                                  .width *
//                                              0.12),
//                                      child: Center(
//                                        child: Row(
//                                          children: <Widget>[
//                                            component.gemIcon,
//                                            Text(
//                                              ' ${component.price}',
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(
//                                          top: MediaQuery.of(context)
//                                                  .size
//                                                  .height *
//                                              0.045),
//                                      child: AutoSizeText(
//                                        component.description,
//                                        textAlign: TextAlign.center,
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ),
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
