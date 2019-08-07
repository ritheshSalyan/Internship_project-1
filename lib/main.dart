import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'PaymentGateway/PaymentGateway.dart';
import 'HustleStore/HustleStore.dart';

void main() async {
//  ChangeNotifierProvider(
//    builder: (context) => PaymentGatewayPage(),
//    child: MyApp(),
//  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'The Startupreneur',
      home: homePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        brightness: Brightness.light,
        primaryColorDark: Colors.white,
        primaryColorLight: Color(0x484848),
        buttonColor: Color(0x009423),
        accentColor: Color(0x009423),
        scaffoldBackgroundColor: Colors.white,
        textSelectionColor: Colors.black,
      ),
      routes: <String, WidgetBuilder>{
        '/hustle': (BuildContext context) => new HustleStore(),
      },
    );
  }
}
