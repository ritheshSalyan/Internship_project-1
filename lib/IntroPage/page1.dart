import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import '../home.dart';

class PageStarter1State extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/Images/air-hostess.png'),
        body: Text(
          'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
        ),
        title: Text(
          '',
        ),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/Images/airplane.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(
        0xFF8BC34A,
      ),
      iconImageAssetPath: 'assets/Images/waiter.png',
      body: Text(
        'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
      ),
      title: Text(
        '',
      ),
      mainImage: Image.asset(
        'assets/Images/hotel.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/Images/taxi-driver.png',
      body: Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/Images/taxi.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white,),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => homePage(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

/// Home Page of our example app.

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ), //Appbar
//       body: Center(
//         child: Text("This is the home page of the app"),
//       ), //Center
//     ); //Scaffold
//   }
// }
