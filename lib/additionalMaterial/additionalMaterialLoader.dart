// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../OfflineBuilderWidget.dart';

// class additionalMaterialLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//      getEventsFromFirestore().then((title) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => ModuleVocabulary(
//             index: widget.index,
//             modNum: widget.modNum,
//             word: words,
//             meaning: meanings,
//           ),
//         ),
//       );
//     });
//     return CustomeOffline(
//       onConnetivity: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new CircularProgressIndicator(
//                 strokeWidth: 5,
//                 value: null,
//                 valueColor: new AlwaysStoppedAnimation(Colors.green),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Material(
//                 color: Colors.transparent,
//                 child: Text(
//                   "Loading... Please Wait",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   static Future<void> getEventsFromFirestore() async {
//     print("hello");
//     await Firestore.instance
//         .collection("vocabulary")
//         .where("module", isEqualTo: modNum)
//         .getDocuments()
//         .then((document) {
//       document.documents.forEach((value) {
//         print(value["word"]);
//         // words.clear();
//         // meanings.clear();
//         for (String i in value["word"]) {
//           print(i);
//           words.add(i);
//         }
//         for (String i in value["meaning"]) {
//           meanings.add(i);
//         }
//       });
//     });
// }