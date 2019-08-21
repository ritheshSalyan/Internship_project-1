import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'internship/DataListing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Component {
  final String description;
  final OutlineButton claimIt;
  final String logo;
  final Image gemIcon;
  final String product;
  final dynamic price;
  final bool decision;

  Component(
      {this.description,
      this.claimIt,
      this.logo,
      this.gemIcon,
      this.product,
      this.price,
      this.decision});
}

 List<Component> item = [];

void generate(BuildContext context) async {
  StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("storeDetail").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        snapshot.data.documents.forEach((document){
        item = [
               Component(
                description: document.data["name"],
                logo: document.data["image"],
                price: document.data["point"],
              )
          ];
        });
      }
  );
}



List<Component> itemList = [
  Component(
    description: "Internships & Projects  ",
    product: "This pack grants you access to listing of high quality internships with curated startups. You can browse through the available opportunities and apply to them. Working at a startup can give you valuable professional experience along with understanding the nuances of building a startup. Think about interning if you are planning to startup after a while or want to experience the startup atmosphere before becoming an entrepreneur. Submit your uploaded CV/Resume to the required company. Apply Here. Good luck with your application!",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 20000,
    decision: true,
    logo:
        "assets/Images/air-hostess.png",
  ),
  Component(
    description: "Startup Incubation  ",
    product: "This pack grants you access to listing of high potential incubation opportunities with some of the top startup incubators in India. You can browse through the available opportunities and apply to them. Incubators provide a great platform to develop, support and move your startup to the next level. Think about incubating if you want to startup right away and kickstart your entrepreneurial journey. Submit your Business Model Canvas to the required Incubator. Apply Here. Good luck with your application!",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {

      },
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 20000,
    decision: true,
    logo:
        "assets/Images/hustle/incubation.png",
  ),
  Component(
    description: "Google Cloud Credits\n Worth \$3000",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 15000,
    product: "This pack grants you and opportunity to access \$3000 worth of Google Cloud Credits. Note that unlocking this pack does not grant you automatic credits worth \$3000 but definitely puts you ahead of the line. The granting of clouds is subject to certain conditions and is purely at the discretion of Google once you submit your application. Please read the conditions here. Google Clouds are a valuable resource if you are planning to build a technology based startup and also if you want to scale up your product online. Apply Here. Good luck with your application! ",
    decision: false,
    logo:
        "assets/Images/hustle/cloud.png"
  ),
  Component(
    description: "Startup Hacks ",
    product: "This pack contains all the tricks to get your startup going. Right from growth hacking to international principles to manage your startup resources. Go ahead, get yourself on the road to becoming a Startupreneur.",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 4000,
    decision: false,
    logo:
        "assets/Images/hustle/hacks.png"
  ),
  Component(
    description: "Payment Gateway\n Benefits",
    product: "This pack grants you access to a zero initial cost payment gateway option from PayU. Being a member of The Startupreneur community will get you benefits from PayU such as discounted merchant rates for payment collection and much more! Apply Here.",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 10000,
    decision: false,
    logo:
       "assets/Images/hustle/payment_gateway.png"
  ),
  // Component(
  //   description: "Secrets to Fundraising Pack",
  //   claimIt: OutlineButton(
  //     onPressed: () {},
  //     child: Text("Claim it"),
  //   ),
  //   gemIcon: Icon(
  //     FontAwesomeIcons.solidGem,
  //     color: Colors.green,
  //     size: 15,
  //   ),
  //   price: 3000,
  //   decision: false,
  //   logo:
  //       "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  // ),
  Component(
    description: "Hustle Document\n Templates",
    product: "This pack contains important document templates such as co-founder’s agreement, terms sheet, presentation templates and user/privacy agreements.Instead of spending thousands of rupees procuring them from the market, we are making these templates available to you for free. Go ahead , get yours now!",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 6000,
    decision: false,
    logo:
       "assets/Images/hustle/document.png"
  ),
  Component(
    description: "Seed Funding\n Grant",
    product: "This pack can be unlocked ONLY after all the other packs are unlocked. Earn 100000 points by helping fellow entrepreneurs join The Stratupreneur mission and earn yourself a surprise seed funding grant of up to Rs.25000 to kickstart your startup!",
    claimIt: OutlineButton(
      borderSide: BorderSide(color: Colors.green,width: 1.2),
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    price: 100000,
    decision: false,
    logo:
       "assets/Images/hustle/funding.png"
  )
];
