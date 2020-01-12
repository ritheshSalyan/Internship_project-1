// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  ImageViewer({Key key, this.image}) : super(key: key);
  final String image;
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  void initState() {

    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    if((widget.image.contains("assets/"))){
      return Scaffold(
      backgroundColor: Colors.white,
      // body: PhotoView(
      //   imageProvider: AssetImage(widget.image),
      // ),
      body: Center(
        child: Image.asset(
          widget.image,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.contain,
          // mode: ExtendedImageMode.Gesture,
          // initGestureConfigHandler: (state) {
          //   return GestureConfig(
          //     minScale: 0.9,
          //     animationMinScale: 0.7,
          //     maxScale: 20.0,
          //     animationMaxScale: 20.5,
          //     speed: 1.0,
          //     inertialSpeed: 100.0,
          //     initialScale: 1.0,
          //     inPageView: false,
          //   );
          // },
        ),
      ),
//    body: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
    );
    }else{
    return Scaffold(
      backgroundColor: Colors.white,
      // body: PhotoView(
      //   imageProvider: AssetImage(widget.image),
      // ),
      body: Center(
        // child: ExtendedImage.network(
        //   widget.image,
        //   height: MediaQuery.of(context).size.height,
        //   fit: BoxFit.contain,
        //   mode: ExtendedImageMode.Gesture,
        //   initGestureConfigHandler: (state) {
        //     return GestureConfig(
        //       minScale: 0.9,
        //       animationMinScale: 0.7,
        //       maxScale: 20.0,
        //       animationMaxScale: 20.5,
        //       speed: 1.0,
        //       inertialSpeed: 100.0,
        //       initialScale: 1.0,
        //       inPageView: false,
        //     );
        //   },
        // ),
      ),
//    body: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
    );
  }
  }
}
