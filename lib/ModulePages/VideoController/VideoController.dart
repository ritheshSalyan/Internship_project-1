import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
// import '../SummaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:video_player/video_player.dart';
import '../../casestudy/CaseStudyEntry.dart';
import '../../ModuleOrderController/Types.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay({Key key,this.modNum ,this.videoLink, this.title, this.btnTitle,this.index})
      : super(key: key);
  final int modNum,index;
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

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
      // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2Fwhat%20is%20startup%20720p.mp4?alt=media&token=5761962c-27a0-4cf1-ab78-c037feff769d',
      widget.videoLink,
    );
    _chewieController = ChewieController(
      autoInitialize: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: const[DeviceOrientation.portraitUp],
      videoPlayerController: _videoPlayerController1,
      placeholder:Center(
        child:  CircularProgressIndicator(
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
      aspectRatio: 16/9,
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Text(
                    widget.title,
                    textAlign:TextAlign.center,
                    style: TextStyle(
                      fontFamily: "QuickSand",
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05)),
            Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
             Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child:  Center(
            child: Text("* Wait and watch the above video to get started!",
            style: TextStyle(fontSize: 18),),
                   
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

                List<dynamic> arguments = [widget.modNum,widget.index+1];
                orderManagement.moveNextIndex(context, arguments);
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
    );
  }
}
