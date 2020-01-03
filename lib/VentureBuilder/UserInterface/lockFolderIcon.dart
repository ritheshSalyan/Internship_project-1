import 'package:flutter/material.dart';

class LockFolderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Icon(
            Icons.folder,
            size: 70,
            color: Colors.black38,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 7.0,
              top: 30,
            ),
            child: Icon(
              Icons.lock,
              size: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}