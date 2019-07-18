import 'package:flutter/material.dart';

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
 final List<String> list = ["Helo","Hiii","world","You","Me"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350,
            title: Text("Start-up Glossary"),
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/Images/vocabulary.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                AnimatedList(
                  itemBuilder,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}