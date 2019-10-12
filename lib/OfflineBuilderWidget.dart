import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';

class CustomeOffline extends StatefulWidget {
  final Widget onConnetivity;
  CustomeOffline({
    @required this.onConnetivity,
  });

  @override
  _CustomeOfflineState createState() => _CustomeOfflineState();
}

class _CustomeOfflineState extends State<CustomeOffline> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: NoNetPage(),
      connectivityBuilder:
          (context, ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return widget.onConnetivity;
        }
        return child;
      },
    );
  }
}
