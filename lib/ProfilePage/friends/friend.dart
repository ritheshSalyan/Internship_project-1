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
    @required this.sid,
    @required this.ventureName,

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
final String sid;
final String ventureName;

}
