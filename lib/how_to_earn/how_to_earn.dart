import 'package:flutter/material.dart';

class HowToEarn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String howToEarn =
        "You earn points when you complete each module. The more modules you complete, the faster the point increment! Once you have completed all the modules, you have a chance to redeem them in the Store.\n\nApart from these, you can earn additional points through inspiring entrepreneurs. So how do you do this?\n\nContribute your effort towards making India an entrepreneurial country. Let your friends, family or any potential entrepreneur know about this platform and get them to join the Startupreneur Revolution! \n\nYou will earn 5000 points for every successful referral, which is when that person joins The Startupreneur platform.\n\nGo ahead, inspire fellow entrepreneurs, earn 100000 points and get yourself a Seed Funding Grant in the Store!\n\nHead to your ‘Profile’ section to find your referral code.\n\nClick the code and it automatically gets copied to your clipboard which can be shared easily via Whatsapp, Text, E-mail or any Social Media platform.\n\n";

    return Scaffold(
      appBar: AppBar(
        title: Text("How to Earn"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Text(
                "How to Earn Points",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  howToEarn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
