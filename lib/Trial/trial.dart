// import 'package:flutter/material.dart';

// class AddRemoveListView extends StatefulWidget {
//   _AddRemoveListViewState createState() => _AddRemoveListViewState();
// }

// class _AddRemoveListViewState extends State<AddRemoveListView> {
//   TextEditingController _textController = TextEditingController();
// Widget button;
// String data = "dchsbdcdc.sdbhchicdc.awhdiweduwed.cunveurnvur.awcieuncenc.vbiuwec.webciecnew.qbcbeuecuewnc";
// int item = 0;
//   List<String> _listViewData = [
//     // "Swipe Right / Left to remove",
//     // "Swipe Right / Left to remove",
 
//   ];


//   @override
//   Widget build(BuildContext context) {
//      button =  Center(
//             child: RaisedButton(
//               onPressed: _onSubmit,
//               child: Text('Add to List'),
//               color: Colors.red,
//             ),
//           );
  
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add & Remove from ListView'),
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(height: 15.0),
//           TextField(
//             controller: _textController,
//             decoration: InputDecoration(
//               hintText: 'enter text to add',
//             ),
//           ),
//           SizedBox(height: 15.0),
        
//           SizedBox(height: 20.0),
//           Expanded(
//             child: ListView(
//               shrinkWrap:true,
//               padding: EdgeInsets.all(10.0),
//               children: convertTolist(),

//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }