import 'dart:convert';
import 'package:meta/meta.dart';

class Friend {
  Friend({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.occupation,
    @required this.institution,
    @required this.mobile,
    @required this.completed,
    @required this.gender,
    @required this.points,
    @required this.uid,

  });

  final String avatar;
  final String name;
  final String email;
  final String gender;
final String occupation;
final String mobile;
final String institution;
final List<dynamic> completed;
final dynamic points;
final String uid;

  // static List<Friend> allFromResponse(String response) {
  //   var decodedJson = json.decode(response).cast<String, dynamic>();

  //   return decodedJson['results']
  //       .cast<Map<String, dynamic>>()
  //       .map((obj) => Friend.fromMap(obj))
  //       .toList()
  //       .cast<Friend>();
  // }

  // static Friend fromMap(Map map) {
  //   var name = map['name'];

  //   return new Friend(
  //     avatar: map['picture']['large'],
  //     name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
  //     email: map['email'],
  //     location: _capitalize(map['location']['state']),
  //   );
  // }

  // static String _capitalize(String input) {
  //   return input.substring(0, 1).toUpperCase() + input.substring(1);
  // }
}
