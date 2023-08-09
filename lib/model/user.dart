import 'package:outage/pages/login.dart';

class Login {
  final String usr_name;
  final String usr_pass;

  Login({
    required this.usr_name,
    required this.usr_pass,
  });
}

class Users extends Login {
  final int usr_id;

  final String usr_nameinit;
  final String usr_firstname;
  final String usr_midname;
  final String usr_lastname;
  final int usr_sdnloc;
  final int usr_mobno;

  final bool usr_isact;

  Users({
    required this.usr_id,
    required this.usr_nameinit,
    required this.usr_firstname,
    required this.usr_midname,
    required this.usr_lastname,
    required this.usr_sdnloc,
    required this.usr_mobno,
    required this.usr_isact,
    required super.usr_name,
    required super.usr_pass,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        usr_id: json['usr_id'],
        usr_name: json['usr_name'],
        usr_nameinit: json['usr_nameinit'],
        usr_firstname: json['usr_firstname'],
        usr_midname: json['usr_midname'],
        usr_lastname: json['usr_lastname'],
        usr_sdnloc: json['usr_sdnloc'],
        usr_mobno: json['usr_mobno'],
        usr_pass: json['usr_pass'],
        usr_isact: json['usr_isact']);
  }
}
