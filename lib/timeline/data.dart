import 'package:flutter/material.dart';

class Doodle {
  final String name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {this.name,
      this.time,
      this.content,
      this.doodle,
      this.icon,
      this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
      name: "Starting up",
      time: "Module 1",
      doodle:
      'https://firebasestorage.googleapis.com/v0/b/startupreneur-ace66.appspot.com/o/videos%2FModule%20-%20Finance.mp4?alt=media&token=d3dff2a6-7a8e-4d3a-ad48-b92b597e357d',         
      icon: Icon(Icons.flag, color: Colors.white),
      iconBackground: Colors.cyan),
 Doodle(
     name: "Ideas",
      time: "Module 2",

     doodle:
         "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.redAccent),
 Doodle(
    name: "Market Analysis",
      time: "Module 3",
     doodle:
         "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.black87,
       size: 32.0,
     ),
     iconBackground: Colors.yellow),
 Doodle(
    name: "Product",
      time: "Module 4",
     doodle:
         "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.black87,
     ),
     iconBackground: Colors.amber),
 Doodle(
     name: "Pricing",
      time: "Module 5",
     doodle:
         "https://www.google.com/logos/doodles/2018/ibn-sinas-1038th-birthday-5768556863029248.2-2x.png",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.green),
 Doodle(
   name: "Business Model",
      time: "Module 6",
     doodle:
         "https://lh3.googleusercontent.com/vk5ODrDXkJXCJ9z2lMnQdMb9m5-HKxDvn_Q67J8PBKPT9n67iCQFj37tB62ARaQQKnKwig-CcBT9NODmzoqdM56_UTUKZRELLYoz1lVU=s800",
     icon: Icon(
     Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.indigo),
 Doodle(
    name: "Legal and Compliance",
      time: "Module 7",
     doodle:
         "https://lh3.googleusercontent.com/UBa5VOLYZNb9sqCZJeMrrS5ZW-KpDBZ7haT8aLPpHzeOZ8K_6TCP03_n-5VKIaewaRVqYkTF09OwvI4oQ2L2IqaUyWlTUkJb4E1uZF0=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.pinkAccent),
 Doodle(
    name: "Branding and Marketing",
      time: "Module 8",
     doodle:
         "https://lh3.googleusercontent.com/429NetsPejpMgeXqZuA15mCFLQykowhHNnbkSa1L8SHq9Kp9De-EBPlmOknzJ_HRykzt5FPhwpju_M3uKeuZlKegwdRQSzrH8NfdwR_B=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
       size: 32.0,
     ),
     iconBackground: Colors.deepPurpleAccent),
 Doodle(
     name: "Team",
      time: "Module 9",
     doodle:
         "https://lh3.googleusercontent.com/TegzHFZQYIfV4lYsaXsZ-CUE_9Lp6qbJZXpSRzTWeLkNiQh0xRbt5KsI4szxN9nUopbyH6d-8tkmV5NcUJtI0Ks79fh-D6nCrKEt5hxR=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.teal),
 Doodle(
     name: "Technology",
      time: "Module 10",
     doodle:
         "https://lh3.googleusercontent.com/9tn671PjT5omvyhJ6xEIiTkkw4ck0vaTeHpyOtwCOE-SEumZbBdKLVFm2sKFRJ6Gkq_uPtYP2Fbss7yxkXgH6IJQruo4c4JT9iILFJZP8A=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
       size: 32.0,
     ),
     iconBackground: Colors.blue),

     Doodle(
     name: "Funding and Financing",
      time: "Module 11",
     doodle:
         "https://lh3.googleusercontent.com/TegzHFZQYIfV4lYsaXsZ-CUE_9Lp6qbJZXpSRzTWeLkNiQh0xRbt5KsI4szxN9nUopbyH6d-8tkmV5NcUJtI0Ks79fh-D6nCrKEt5hxR=s660",
     icon: Icon(
       Icons.account_balance,
       color: Colors.white,
     ),
     iconBackground: Colors.teal),
 Doodle(
     name: "Business plan and Go to Market",
      time: "Module 12",
     doodle:
         "https://lh3.googleusercontent.com/9tn671PjT5omvyhJ6xEIiTkkw4ck0vaTeHpyOtwCOE-SEumZbBdKLVFm2sKFRJ6Gkq_uPtYP2Fbss7yxkXgH6IJQruo4c4JT9iILFJZP8A=s660",
     icon: Icon(
       Icons.star,
       color: Colors.white,
       size: 32.0,
     ),
     iconBackground: Colors.blue),
];
