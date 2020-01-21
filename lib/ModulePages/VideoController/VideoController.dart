import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
// import '../SummaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/OfflineBuilderWidget.dart';
import 'package:startupreneur/VentureBuilder/TabUI/module_controller.dart';
import 'package:startupreneur/globalKeys.dart';
import 'package:startupreneur/saveProgress.dart';
import 'package:video_player/video_player.dart';
import '../../ModuleOrderController/Types.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay(
      {Key key,
      this.modNum,
      this.videoLink,
      this.title,
      this.btnTitle,
      this.index})
      : super(key: key);
  final int modNum, index;
  final String videoLink;
  final String btnTitle;
  final String title;
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayState();
  }
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Analytics.analyticsBehaviour("Video_Story_Page", "VideoPage");
    _videoPlayerController1 = VideoPlayerController.network(
      widget.videoLink,
    );
    _initializeVideoPlayerFuture = _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      autoInitialize: true,
      allowedScreenSleep: true,
      deviceOrientationsAfterFullScreen: const [DeviceOrientation.portraitUp],
      videoPlayerController: _videoPlayerController1,
      placeholder: Center(
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation(Colors.green),
          strokeWidth: 5.0,
        ),
      ),
      materialProgressColors: ChewieProgressColors(
        backgroundColor: Colors.green,
        playedColor: Colors.red,
        bufferedColor: Colors.black,
        handleColor: Colors.blue,
      ),
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
    // _initializeVideoPlayerFuture = _chewieController.i
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _videoPlayerController1.pause();
    _chewieController.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    ModuleTraverse traverse = Provider.of<ModuleTraverse>(context);
    return
        //  CustomeOffline(
        //   onConnetivity:
        Scaffold(
      //      bottomSheet: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: <Widget>[
      //     Text(
      //        "Page ${widget.index+1}/${Module.moduleLength}",
      //       textAlign: TextAlign.center,
      //       style: TextStyle(color: Colors.green),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          bottom: 5.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Page ${widget.index + 1}/${Module.moduleLength}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              traverse.navigateBack();
            },
          ),
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.home),
            onTap: () {
              showDialog<bool>(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Text(
                          "Are you sure you want to return to Home Page? "),
                      title: Text(
                        "Warning!",
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            // SaveProgress.preferences(
                            //     widget.modNum, widget.index);
                            // Navigator.of(context).popUntil(ModalRoute.withName("/QuoteLoading"));
                            // Navigator.of(context).popUntil(
                            //     ModalRoute.withName("TimelinePage"));
                            Provider.of<ModuleTraverse>(context).navigate();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                height: MediaQuery.of(context).size.height * 0.19,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Center(
              child: Text(
                "* Wait and watch the above video to get started!",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
            OutlineButton(
              borderSide: BorderSide(
                color: Colors.green,
                width: 1.5,
              ),
              onPressed: () {
                // if (widget.btnTitle == "Tap to continue") {
                //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => Loading(),
                //   ));
                // }
                // else{
                //    Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => SummaryPage(),
                //   ));
                // }

                // List<dynamic> arguments = [widget.modNum, widget.index + 1];
                // orderManagement.moveNextIndex(context, arguments);

                traverse.navigate();
              },
              child: Text(
                widget.btnTitle,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
