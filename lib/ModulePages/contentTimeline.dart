import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
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
      'assets/videos/video.mp4',
    );
    _chewieController = ChewieController(
      autoInitialize: true,
      isLive: false,
      videoPlayerController: _videoPlayerController1,
      materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.green,
          playedColor: Colors.red,
          bufferedColor: Colors.black,
          handleColor: Colors.blue),
      aspectRatio: 16 / 10,
      autoPlay: false,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
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
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              decoration: BoxDecoration(color: Colors.green),
              height: 200,
              width: double.infinity,
              child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              "Here you go",
              style: TextStyle(
                fontFamily: "QuickSand",
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
          ),
          Center(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ],
      ),
    );
  }
}
