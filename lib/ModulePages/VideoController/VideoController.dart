import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import '../../timeline/MainRoadmap.dart';
import '../SummaryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:video_player/video_player.dart';
import '../../casestudy/CaseStudyEntry.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay({Key key, this.videoLink, this.title, this.btnTitle})
      : super(key: key);
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
    _videoPlayerController1 = VideoPlayerController.asset(
      // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2Fwhat%20is%20startup%20720p.mp4?alt=media&token=5761962c-27a0-4cf1-ab78-c037feff769d',
      widget.videoLink,
    );
    _chewieController = ChewieController(
      autoInitialize: true,
      isLive: false,
      videoPlayerController: _videoPlayerController1,
      materialProgressColors: ChewieProgressColors(
        backgroundColor: Colors.green,
        playedColor: Colors.red,
        bufferedColor: Colors.black,
        handleColor: Colors.blue,
      ),
      aspectRatio: 9 / 5,
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
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
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
                top: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
            OutlineButton(
              borderSide: BorderSide(
                color: Colors.green,
                width: 1.5,
              ),
              onPressed: () {
                if (widget.btnTitle == "Tap to continue") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Loading(),
                  ));
                }
                else{
                   Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SummaryPage(),
                  ));
                }
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
