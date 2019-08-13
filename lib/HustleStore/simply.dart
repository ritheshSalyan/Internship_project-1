import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Component {
  String name;
  String description;
  String image;
  dynamic points;

  Component({
    this.points,
    this.description,
    this.image,
    this.name,
  });
}

class HustleStore extends StatefulWidget {
  HustleStore({Key key, this.points}) : super(key: key);
  final dynamic points;
  @override
  _HustleStoreState createState() => _HustleStoreState();
}

class _HustleStoreState extends State<HustleStore> {
  SharedPreferences sharedPreferences;
  String userId;
  Firestore db;
  List<Color> color = [
    Color.fromRGBO(222, 30, 89, 1),
    Color.fromRGBO(59, 40, 127, 1)
  ];
  List<Widget> list = [];
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
        title: Text(
          "Hustle Store",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("storeDetails").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.data) {
                  case null:
                    return Text("on the way");
                  default:
                    list.clear();
                    snapshot.data.documents.forEach((document) {
                      print(document.data["image"].runtimeType);
                      list.add(
                        Container(
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
                                  borderRadius: BorderRadius.circular(15)),
                              gradient: LinearGradient(colors: color),
                              elevation: 12.0,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    child: planetThumbnail(
                                        context, "${document.data["image"]}"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
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
                                              "${document.data["name"]}",
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
                                              Image.asset(
                                                "assets/Images/coins.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05),
                                              ),
                                              Text(
                                                // "",
                                                ' ${document.data["point"]}',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                        ),
                      );
                    });
                    print(list.length);
                    return GestureDetector(
                      onTap: () {
                        print("you tapped ");
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                       itemBuilder: (context,int index){
                         return Column(
                            children: list,
                         );
                       },
                      ),
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
