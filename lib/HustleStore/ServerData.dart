import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Component {
  final String description;
  final RaisedButton claimIt;
  final String logo;
  final Icon gemIcon;
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

List<Component> itemList = [
  Component(
    description: "Internships Pack ",
    product: "This pack grants you access to listing of high quality internships with curated startups. You can browse through the available opportunities and apply to them. Working at a startup can give you valuable professional experience along with understanding the nuances of building a startup. Think about interning if you are planning to startup after a while or want to experience the startup atmosphere before becoming an entrepreneur. Submit your uploaded CV/Resume to the required company. Apply Here. Good luck with your application!",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 20000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Startup Incubation Pack ",
    product: "This pack grants you access to listing of high potential incubation opportunities with some of the top startup incubators in India. You can browse through the available opportunities and apply to them. Incubators provide a great platform to develop, support and move your startup to the next level. Think about incubating if you want to startup right away and kickstart your entrepreneurial journey. Submit your Business Model Canvas to the required Incubator. Apply Here. Good luck with your application!",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 20000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Google Cloud Credits worth \$3000",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 15000,
    product: "This pack grants you and opportunity to access \$3000 worth of Google Cloud Credits. Note that unlocking this pack does not grant you automatic credits worth \$3000 but definitely puts you ahead of the line. The granting of clouds is subject to certain conditions and is purely at the discretion of Google once you submit your application. Please read the conditions here. Google Clouds are a valuable resource if you are planning to build a technology based startup and also if you want to scale up your product online. Apply Here. Good luck with your application! ",
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Hustle Tricks Pack",
    product: "This pack contains all the tricks to get your startup going. Right from growth hacking to international principles to manage your startup resources. Go ahead, get yourself on the road to becoming a Startupreneur.",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 4000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Free Payment Gateway Pack",
    product: "This pack grants you access to a zero initial cost payment gateway option from PayU. Being a member of The Startupreneur community will get you benefits from PayU such as discounted merchant rates for payment collection and much more! Apply Here.",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 10000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  // Component(
  //   description: "Secrets to Fundraising Pack",
  //   claimIt: RaisedButton(
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
    description: "Hustle Document Templates",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 6000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Startup Projects Pack",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 20000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "Seed Funding Grant",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100000,
    decision: false,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  )
];
