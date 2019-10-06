import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Doodle {
  final AutoSizeText name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  final Image pointsIcon;
  final Text points;
  final Color color;
  List<Color> colors = [];
  final int modNum;

  // final Text
  Doodle({
    this.name,
    this.time,
    this.content,
    this.doodle,
    this.icon,
    this.iconBackground,
    this.pointsIcon,
    this.points,
    this.color,
    this.colors,
    this.modNum,
  });
}

List<Doodle> doodles = [
  new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 1,
    name: AutoSizeText(
      "Starting Up",
      style: TextStyle(
//                            color: Colors.white,
        // fontSize: 16,
        letterSpacing: 0.5,
        // fontFamily: "Open Sans",
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ),
    time: "Module 1",
    doodle: "assets/Images/StaringUpIcon.png",
    // doodle: "assets/Images/gcloud.png",
    // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',
    icon: Icon(
      Icons.flag,
      color: Colors.white,
    ),
    iconBackground: Colors.green,
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${1000}",
    ),
    color: Colors.grey[100],
  ),
 
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 2,
    name: AutoSizeText(
      "Idea",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 10,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    time: "Module 2",
    doodle: "assets/Images/ideaIcon2.png",
    // doodle: "assets/Images/hustle/document.png",

    // "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${1500}",
    ),
    color: Colors.grey[100],
  ),
    new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 13,
    name: AutoSizeText(
      "Market Research I",
      style: TextStyle(
//                            color: Colors.white,
        // fontSize: 16,
        letterSpacing: 0.5,
        // fontFamily: "Open Sans",
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ),
    time: "Module 13",
    doodle: "assets/Images/StaringUpIcon.png",
    // doodle: "assets/Images/gcloud.png",
    // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',
    icon: Icon(
      Icons.flag,
      color: Colors.white,
    ),
    iconBackground: Colors.green,
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${2000}",
    ),
    color: Colors.grey[100],
  ),
    new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 14,
    name: AutoSizeText(
      "Market Research II",
      style: TextStyle(
//                            color: Colors.white,
        // fontSize: 16,
        letterSpacing: 0.5,
        // fontFamily: "Open Sans",
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    ),
    time: "Module 14",
    doodle: "assets/Images/StaringUpIcon.png",
    // doodle: "assets/Images/gcloud.png",
    // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',
    icon: Icon(
      Icons.flag,
      color: Colors.white,
    ),
    iconBackground: Colors.green,
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${2500}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 3,
    name: AutoSizeText(
      "Ethical Foundations",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    time: "Module 3",
    doodle: "assets/Images/ethicsIcon.png",
    // doodle: "assets/Images/hustle/funding.png",
    // "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${3000}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum:4,
    name: AutoSizeText(
      "Product",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    time: "Module 4",
    doodle: "assets/Images/productIcon.png",
    // "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${3500}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 5,
    name: AutoSizeText(
      "Business Model",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
   
    time: "Module 5",
    doodle: "assets/Images/marketAnalyaisIcon.png",
    // "https://lh3.googleusercontent.com/vk5ODrDXkJXCJ9z2lMnQdMb9m5-HKxDvn_Q67J8PBKPT9n67iCQFj37tB62ARaQQKnKwig-CcBT9NODmzoqdM56_UTUKZRELLYoz1lVU=s800",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${4000}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Pricing",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 6,
    time: "Module 6",
    doodle: "assets/Images/6.png",
    // "https://www.google.com/logos/doodles/2018/ibn-sinas-1038th-birthday-5768556863029248.2-2x.png",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${4500}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],

    name: AutoSizeText(
      "Legal and Compliance",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 7,
    time: "Module 7",
    doodle: "assets/Images/leagal.png",
    // "https://lh3.googleusercontent.com/UBa5VOLYZNb9sqCZJeMrrS5ZW-KpDBZ7haT8aLPpHzeOZ8K_6TCP03_n-5VKIaewaRVqYkTF09OwvI4oQ2L2IqaUyWlTUkJb4E1uZF0=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${5000}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Branding and Marketing",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 8,
    time: "Module 8",
    doodle: "assets/Images/brandingIcon.png",
    // "https://lh3.googleusercontent.com/429NetsPejpMgeXqZuA15mCFLQykowhHNnbkSa1L8SHq9Kp9De-EBPlmOknzJ_HRykzt5FPhwpju_M3uKeuZlKegwdRQSzrH8NfdwR_B=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${5500}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Team",
      style: TextStyle(
//           color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 9,
    time: "Module 9",
    doodle: "assets/Images/teamIcon.png",
    // "https://lh3.googleusercontent.com/TegzHFZQYIfV4lYsaXsZ-CUE_9Lp6qbJZXpSRzTWeLkNiQh0xRbt5KsI4szxN9nUopbyH6d-8tkmV5NcUJtI0Ks79fh-D6nCrKEt5hxR=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${6000}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Technology",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 10,
    time: "Module 10",
    doodle: "assets/Images/technologyIcon.png",
    // "https://lh3.googleusercontent.com/9tn671PjT5omvyhJ6xEIiTkkw4ck0vaTeHpyOtwCOE-SEumZbBdKLVFm2sKFRJ6Gkq_uPtYP2Fbss7yxkXgH6IJQruo4c4JT9iILFJZP8A=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    color: Colors.grey[100],
    points: Text(
      "${6500}",
    ),
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Funding and Financing",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 11,
    time: "Module 11",
    doodle: "assets/Images/fundingIcon.png",
    // "https://lh3.googleusercontent.com/TegzHFZQYIfV4lYsaXsZ-CUE_9Lp6qbJZXpSRzTWeLkNiQh0xRbt5KsI4szxN9nUopbyH6d-8tkmV5NcUJtI0Ks79fh-D6nCrKEt5hxR=s660",
    icon: Icon(
      FontAwesomeIcons.circle,
      // Icons.
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${7000}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    name: AutoSizeText(
      "Go to Market",
      style: TextStyle(
//                            color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    modNum: 12,
    //Business plan and
    time: "Module 12",
    doodle: "assets/Images/gotoMarket.png",
    // "https://lh3.googleusercontent.com/9tn671PjT5omvyhJ6xEIiTkkw4ck0vaTeHpyOtwCOE-SEumZbBdKLVFm2sKFRJ6Gkq_uPtYP2Fbss7yxkXgH6IJQruo4c4JT9iILFJZP8A=s660",
//
    // icon: Icon(
    //   Icons.store,
    //   size: 24,
    //   // Icons.
    //   color: Colors.white,
    // ),
    icon: Icon(
      FontAwesomeIcons.trophy,
      size: 24,
      // Icons.
      color: Colors.white,
    ),
    iconBackground: Colors.green,
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${7500}",
    ),
    color: Colors.grey[100],
  ),
  Doodle(
    colors: [Color.fromRGBO(222, 30, 89, 1), Color.fromRGBO(59, 40, 127, 1)],

    name: AutoSizeText(
      "Store",
      style: TextStyle(
          color: Colors.white,
          // fontSize: 16,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    //Business plan andm
    modNum: -1,
    time: "Module 13",
    doodle: "assets/Images/hustel.png",
    // "https://lh3.googleusercontent.com/9tn671PjT5omvyhJ6xEIiTkkw4ck0vaTeHpyOtwCOE-SEumZbBdKLVFm2sKFRJ6Gkq_uPtYP2Fbss7yxkXgH6IJQruo4c4JT9iILFJZP8A=s660",
    icon: Icon(
      Icons.store,
      size: 24,
      // Icons.
      color: Colors.white,
    ),
    // icon: Icon(
    //   FontAwesomeIcons.trophy,
    //   size: 24,
    //   // Icons.
    //   color: Colors.white,
    // ),
    iconBackground: Colors.green,
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 0,
      width: 0,
    ),
    points: Text(
      "Redeem your \nEarnings",
      style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          letterSpacing: 0.5,
          // fontFamily: "Open Sans",
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
    color: Colors.green,
  ),
];
