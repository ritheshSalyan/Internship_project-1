import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  ImageViewer({Key key,this.image}):super(key:key);
  final String image;
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PhotoView(
        imageProvider: AssetImage(widget.image),
      ),
//    body: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
    );
  }
}
