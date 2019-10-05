import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DiagonallyCutColoredImage extends StatelessWidget {
  DiagonallyCutColoredImage(this.image, {@required this.color});

  final Image image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new DiagonalClipper(),
      child: new DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: new BoxDecoration(color: color),
        child: image,
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;

    Path ovalPath = new  Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height);

    // paint a curve from current position to middle of the screen
   ovalPath.quadraticBezierTo( width * 0.7, height * 0.7, width * 0.51, height * 0.3);

    // Paint a curve from current position to bottom left of screen at width * 0.1
   ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width, height*0.1);

    // draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);

    ovalPath.close();

    return ovalPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}