import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ModuleVocabulary extends StatefulWidget {
  ModuleVocabulary({Key key , this.modNum}):super(key:key);
  final int modNum;
  @override
  _ModuleVocabularyState createState() => _ModuleVocabularyState();
}

class _ModuleVocabularyState extends State<ModuleVocabulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context){
          return SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                        decoration: BoxDecoration(color: Colors.green),
                        height: MediaQuery.of(context).size.height*0.3,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}