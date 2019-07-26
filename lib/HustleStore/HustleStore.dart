import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'ServerData.dart';

class HustleStore extends StatefulWidget {
  @override
  _HustleStoreState createState() => _HustleStoreState();
}

class _HustleStoreState extends State<HustleStore> {
  int gems = 1000;
  int i = itemList.length;

  @override
  initState() {
    super.initState();
    // print(i);
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    return  MaterialButton(
      minWidth: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.7,
        elevation: 1.0,
        highlightElevation: 1.0,
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey.shade800,
        textColor: Colors.white70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
    );
  }

  Widget _buildCategoryItem2(BuildContext context, int index) {
    final component = itemList[index];
    print(component.logo);
    return GestureDetector(
      onTap: () {
        print("You tapped $index");
      },
     child: Container(

      )
    );
  }

  @override
  Widget build(BuildContext context) {
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
                "$gems",
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
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    _buildCategoryItem,
                    childCount: i,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
