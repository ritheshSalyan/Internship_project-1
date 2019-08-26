import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:startupreneur/HustleStore/detailingPage/detailing.dart';
import 'googleCloud/googleCloudLoader.dart';
import 'hacks/startup_hacks_loader.dart';
import 'incubation/incubation.dart';
import 'paymentGateway/paymentGatewayLoader.dart';
import 'seedFunding/seedFundingLoader.dart';
import 'template/templateLoader.dart';
import 'internship/DataListingLoader.dart';
import'hyperLinkPage/hyperLinkPage.dart';


class Component {
  String name;
  String description;
  String image;
  dynamic points;
  String type;
  List<dynamic> claimed;

  Component({
    this.points,
    this.description,
    this.image,
    this.name,
    this.type,
    this.claimed,
  });
}

class HustleStore extends StatefulWidget {
  HustleStore({Key key, this.point}) : super(key: key);
  final dynamic point;
  @override
  _HustleStoreState createState() => _HustleStoreState();
}

class _HustleStoreState extends State<HustleStore> {
  SharedPreferences sharedPreferences;
  String userId;
  bool flag = false;
  List<dynamic> claimedUser = [];
  Firestore db;
  List<Color> color = [
    Color.fromRGBO(222, 30, 89, 1),
    Color.fromRGBO(59, 40, 127, 1)
  ];
  List<dynamic> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferences();
    db = Firestore.instance;
  }

  void preferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString("UserId");
  }

  Widget planetThumbnail(BuildContext context, String logo) {
    print("inside thumbanial");
    return new Container(
//      height: MediaQuery.of(context).size.height * 0.3,
//    margin: new EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.1),
        alignment: FractionalOffset.centerLeft,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35,
          child: new Image(
            image: new AssetImage(logo),
            height: 60.0,
            width: 60.0,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: AutoSizeText(
          "GoldMine",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.1,
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
                  "   ${widget.point}",
                  maxLines: 2,
                  style: TextStyle(
                    // fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("storeDetails").orderBy("id").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.data) {
                  case null:
                    return Center(
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                      ),
                    );
                  default:
                    list.clear();
                    snapshot.data.documents.forEach(
                      (document) {
                        print(document.data["image"].runtimeType);
                        list.add(
                          Component(
                            name: document.data["name"],
                            image: document.data["image"],
                            points: document.data["point"],
                            description: document.data["description"],
                            claimed: document.data["claimed"],
                            type: document.data["type"],
                          ),
                        );
                      },
                    );
                    print(list[0].name);
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print(list[index].type);
                            switch (list[index].type) {
                              case "funding":
                                print("hello world");
                                claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => seedFundingLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              case "template":
                                print("Template");
                               claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                  break;
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>TemplateLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                      maintainState: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              case "incubation":
                                print("incubation");
                                claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Incubation(title: "Incubation",),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                                
                              case "gateway":
                                print("gateway");
                               claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialogHyperLink(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                        link: "https://register.payumoney.com/Startupreneur_Incubator",
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => paymentGatewayLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialogHyperLink(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                        link: "https://register.payumoney.com/Startupreneur_Incubator",
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              case "internship":
                                claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DataListingLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              case "credits":
                                print("google credits");
                                claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialogHyperLink(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                        link: "https://cloud.google.com/developers/startups/",
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => googleCloudLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialogHyperLink(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                        link: "https://cloud.google.com/developers/startups/",
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              case "hacks":
                                print("Hacks");
                                claimedUser.clear();
                                print("${list[index].claimed.length}");
                                if (list[index].claimed.length == 0) {
                                  print("inisde if");
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                } else {
                                  print("inside else");
                                  for (var i in list[index].claimed) {
                                    if (userId == i) {
                                      setState(() {
                                        claimedUser.add(i);
                                        flag = true;
                                      });
                                      break;
                                    } else {
                                      claimedUser.add(i);
                                      continue;
                                    }
                                  }
                                  if (flag) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => startupHacksLoader(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddEntryDialog(
                                        points: list[index].points,
                                        available: widget.point,
                                        descript: list[index].description,
                                        image: list[index].image,
                                        title: "",
                                        userid: userId,
                                        claimedUser: claimedUser,
                                        len: 12,
                                        type: list[index].type,
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                }
                                }
                                
                                break;
                              default:
                                print("none");
                                break;
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                            margin: new EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            decoration: new BoxDecoration(
                              color: Colors.grey[300],
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                gradient: LinearGradient(colors: color),
                                elevation: 12.0,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                      ),
                                      child: planetThumbnail(
                                          context, "${list[index].image}"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 150,
                                              height: 50,
                                              child: AutoSizeText(
                                                // "",
                                                "${list[index].name}",
                                                textAlign: TextAlign.center,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                ExtendedImage.asset(
                                                  "assets/Images/coins.png",
                                                  height: 20,
                                                  width: 20,
                                                  enableLoadState: true,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05,
                                                  ),
                                                ),
                                                Text(
                                                  // "",
                                                  ' ${list[index].points}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
