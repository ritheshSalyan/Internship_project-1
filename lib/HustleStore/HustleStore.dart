import 'package:flutter/material.dart';
import 'package:startupreneur/HustleStore/template/templateLoader.dart';
import 'ServerData.dart';
import 'FullScreenDialog.dart';
import 'internship/DataListing.dart';
import 'incubation/incubation.dart';
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
  Component component = new Component();

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

  // Widget planetThumbnail(BuildContext context, String logo) => new Container(
  //       alignment: FractionalOffset.centerLeft,
  //       child: CircleAvatar(
  //         backgroundColor: Colors.transparent,
  //         radius: 8000,
  //         child: new Image(
  //           image: new AssetImage(logo),
  //           // height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width
  //         ),
  //       ),
  //     );
  Widget planetThumbnail(BuildContext context, String logo) => new Image(
        image: new AssetImage(logo),
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );


  Widget planetCard(BuildContext context, int index, String description,
          Image gemIcon, int price, OutlineButton button, String logo) =>
      new Container(
  //  color: Colors.black,
        // height: MediaQuery.of(context).size.height,
        margin:
            new EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            gradient: LinearGradient(colors: color),
            elevation: 12.0,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0,
                  ),
                  child: planetThumbnail(context, logo),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0,
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width * 0.5;
    height = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    expandedHeight: MediaQuery.of(context).size.height * 0.05,
                    backgroundColor: Theme.of(context).primaryColor,
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
                    flexibleSpace: FlexibleSpaceBar(),
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
                                        .push(MaterialPageRoute(
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
                                  } else if (index == 5) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => TemplateLoader(),
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
                              child: new Stack(
                                children: <Widget>[
                                  planetCard(
                                    context,
                                    index,
                                    component.description,
                                    component.gemIcon,
                                    component.price,
                                    component.claimIt,
                                    component.logo,
                                  ),
                                ],
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
