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
  String modName;
  final Color color;
  List<Color> colors = [];
  final int modNum;
  final String modDec;

  // final Text
  Doodle({
    this.name,
    this.time,
    this.content,
    this.doodle,
    this.modName,
    this.icon,
    this.iconBackground,
    this.pointsIcon,
    this.points,
    this.color,
    this.colors,
    this.modNum,
    this.modDec,
  });
}

 List<int> moduleOrder = [1,2,13,14,3,4,5,6,7,8,9,10,11,12];

List<Doodle> doodles = [
  new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 1,
    modName: "Starting Up",
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
    modDec: "",
  ),
 
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 2,
    modName: "Idea",
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
    modDec: "Discover the various ways in which sustainable startup ideas are generated, understand the various techniques and how you can master the rationale behind building one."
  ),
    new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 13,
    modName: "Market Research I",
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
    doodle: "assets/Images/analysis.png",
    // doodle: "assets/Images/gcloud.png",
    // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',
    icon: Icon(
     FontAwesomeIcons.circle,
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${2000}",
    ),
    color: Colors.grey[100],
    modDec: "Learn how the greatest startups across the globe are adopting the ‘Disciplined Entrepreneurship’ principles using iterate, value creation and the testing approach."
  ),
    new Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 14,
    modName: "Market Research II",
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
    doodle: "assets/Images/analysis.png",
    // doodle: "assets/Images/gcloud.png",
    // 'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',
    icon: Icon(
      FontAwesomeIcons.circle,
      color: Colors.green,
    ),
    iconBackground: Colors.grey[50],
    pointsIcon: Image.asset(
      "assets/Images/coins.png",
      height: 20,
      width: 20,
    ),
    points: Text(
      "${2500}",
    ),
    color: Colors.grey[100],
    modDec: "Discover how to use design thinking to build a product that your customers love from day zero. Know, test, validate your target customers and estimate your market size and problem potential."
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 3,
    modName: "Ethical Foundations",
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
    modDec: "Build a strong Ethical foundation for your startup and master the art of balancing people, planet and profits in today’s world of business impact."
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum:4,
    modName: "Product",
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
    modDec: "Learn how to build a winning product in the most time and cost efficient manner. Adapt your product to the needs of the customers by building brochures and high-level specifications to iterate on.Identifying the right product-market fit and gain your first customers and that can sustain existing customers for a long period of time."
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modNum: 5,
    modName: "Business Model",
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
    modDec: "Understand the 9 building blocks of the famous ‘Business Model Canvas’ and build your dream business model that is practical, feasible and scalable.Get in-depth insights into what forms a business model that can adapt and sustain across markets and growth cycles."
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modName: "Pricing",
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
    modDec: "Discover the various pricing strategies such as skimming, bundling, etc to suit your product and learn about how billion dollar startups like Netflix have been able to get their pricing right.Build a strong brand that can attract potential customers and find out the various ways in which you can market your product to the customer through an effective sales strategy."
  ),
  Doodle(
    colors: [Colors.grey[100], Colors.grey[100]],
    modName: "Legal and Compliance",
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
    modDec: "Get to know the various forms of companies present in India and which one suits best for you, understand the various legal compliances involved in starting up and how you can stay on top of them without getting disrupted.  Learn how you can manage intellectual property and benefit from registering with Startup India."
  ),
  Doodle(
    modName: "Branding and Marketing",
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
    modDec: "Build a strong brand that can attract potential customers and find out the various ways in which you can market your product to the customer through an effective sales strategy."
  ),
  Doodle(
    modName: "Team",
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
    modDec: "Understand the ways in which you can establish a complimentary relationship with your co-founder and take the all-important decision of splitting equity among the founders.  Learn how to build a strong team and how to establish the right culture that fuels and sustains your startup growth and identify ways in which you can find the right mentors and receive expert guidance for your startup.  Master the art of hiring your early employees that can make sure you have a complete team that can handle all the critical functions."
  ),
  Doodle(
    modName: "Technology",
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
    modDec: "Get up to speed with the best of emerging technologies and learn how to leverage the best technology tools in building your product.Discover realistic insights into the ‘hyped-up’ technologies and their life cycles and how to start a technology based venture even if you have a non-technical background."
  ),
  Doodle(
    modName: "Funding and Financing",
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
    modDec: "Maintaining the capital reserves is as important as building the product for a startup.  Discover the different forms of fundraising - Bootstrapping, Angel Investment, Venture Capital, Private Equity, Grants, Loans, Crowdfunding and more.  Learn the nitty gritty of fundraising - Elevator Pitch, Pitch Deck, Key Metrics, Startup Valuation, Term Sheets, Due Diligence etc."
  ),
  Doodle(
    modName: "Go to Market",
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
    modDec: "Prepare a comprehensive strategy for your product launch, redefine your pitch deck and get ready to enter the market!"
  ),
  Doodle(
    colors: [Color.fromRGBO(222, 30, 89, 1), Color.fromRGBO(59, 40, 127, 1)],
    modName: "Store",
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
