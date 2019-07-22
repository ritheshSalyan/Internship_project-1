import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  VideoApp({Key key, this.link}) : super(key: key);
  final String link;
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.link,
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Container(
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(
                    child: Center(
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: false,
                        colors: VideoProgressColors(
                          playedColor: Colors.green,
                          bufferedColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    if (_controller.value.isPlaying) {
                      _controller.seekTo(Duration(seconds: 10));
                    }
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.fast_forward
                        : Icons.fast_forward,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: _controller.value.isPlaying
                      ? _controller.pause
                      : _controller.play,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  onPressed: () {
                    if (!_controller.value.isPlaying) {
                      _controller.seekTo(Duration(seconds: 0));
                    }
                  },
                  child: Icon(
                    _controller.value.isPlaying ? Icons.repeat : Icons.repeat,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
