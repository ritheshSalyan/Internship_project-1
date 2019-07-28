import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Component {
  final String description;
  final RaisedButton claimIt;
  final String logo;
  final Icon gemIcon;
  final int price;

  Component(
      {this.description, this.claimIt, this.logo, this.gemIcon, this.price});
}

List<Component> itemList = [
  Component(
    description: "LoVelit eli",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "LoVelit eli",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "LoVelit",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "LoVelit eli",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "LoVelit eli",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  ),
  Component(
    description: "LoVelit eli",
    claimIt: RaisedButton(
      onPressed: () {},
      child: Text("Claim it"),
    ),
    gemIcon: Icon(
      FontAwesomeIcons.solidGem,
      color: Colors.green,
      size: 15,
    ),
    price: 100,
    logo:
        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  )
];