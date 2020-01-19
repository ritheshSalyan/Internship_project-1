import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ActivityIntro extends StatefulWidget {
  ActivityIntro({this.intro, this.heading, this.index,this.modName,this.modNum,this.files,this.buttons});
  List intro, heading,buttons;
  int index;
  dynamic files;
  dynamic modNum,modName;
  @override
  _ActivityIntroState createState() => _ActivityIntroState();
}

class _ActivityIntroState extends State<ActivityIntro> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF48B9A9),
                gradient: LinearGradient(
                  colors: [
                    Colors.green,
                    Color(0xFF30B8AA),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: AutoSizeText(
                            "${widget.heading[widget.index]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            minFontSize: 20,
                            maxFontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AutoSizeText(
                        "${widget.intro[widget.index]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                        minFontSize: 18,
                        maxFontSize: 25,
                        maxLines: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  (widget.buttons[widget.index]!=null && widget.buttons[widget.index].isNotEmpty)?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      // alignment: Alignment.center,
                      onPressed: (){},
                      child: AutoSizeText(
                        "${widget.buttons[widget.index]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.1,
                        ),
                        minFontSize: 18,
                        maxFontSize: 25,
                        maxLines: 15,
                      ),
                    ),
                  ):Container(),
                 
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
