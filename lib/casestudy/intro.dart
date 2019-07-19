import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dot_animation_enum.dart';
import 'intro_slider.dart';
import 'slide_object.dart';



class IntroScreen extends StatefulWidget {
  IntroScreen({Key key,this.dialogue}) : super(key: key);
  List<String> dialogue;

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
   List<String> dialogue;
  Function goToTab;

  @override
  void initState() {
    super.initState();
  }
  
  void createSlides(){
      for (String item in dialogue) {
         slides.add(
      new Slide(
        description:
            item,
        styleDescription: TextStyle(
            color:Colors.green,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            fontFamily: 'Open Sans'),
        pathImage: "assets/Images/character.png",
      ),
    );
      }

  }
  void onDonePress() {
    // Back to the first tab
    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.green,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color:Colors.green,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.green,
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        // width: double.infinity,
        // height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top:00),
            child: Container(
          
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
             
              // Container(
              //   child: Text(
              //     currentSlide.title,
              //     style: currentSlide.styleTitle,
              //     textAlign: TextAlign.start,
              //   ),
              //   margin: EdgeInsets.only(top: 20.0),
              // ),
              Container(
                alignment: Alignment.center,
                child:Padding( 
                  padding: EdgeInsets.only(left: 19,top: 0,right: 10),
                  child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.start,
                  
                  overflow: TextOverflow.visible,
                ),
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
               GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 400.0,
                fit: BoxFit.contain,
              )),
            ],
          ),
        ),
          ),
        )
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
     dialogue = widget.dialogue;
     createSlides();
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      // renderSkipBtn: this.renderSkipBtn(),
      // colorSkipBtn:Colors.green[200],
      // highlightColorSkipBtn: Colors.green[300],

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.green[200],
      highlightColorDoneBtn: Colors.green[300],

      // Dot indicator
      colorDot: Colors.green[200],
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
