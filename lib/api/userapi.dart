import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:outage/model/rlmfeeder.dart';
import 'package:realm/realm.dart';
import '../model/user.dart';

class UserAPI {
  static Future<Users> checkLogin(Login lgn) async {
    print("login detail " + lgn.toJson().toString());
    Users user = Users(
        usr_id: 0,
        usr_nameinit: "",
        usr_firstname: "",
        usr_midname: "",
        usr_lastname: "",
        usr_sdnloc: 0,
        usr_mobno: 0,
        usr_isact: false,
        usr_name: "",
        usr_pass: "");

    var url = Uri.parse('http://10.35.152.22:3000/api/user/login');

    final resp = await http.post(
      url,
      // headers: {
      //   'Content-Type': 'application/json',
      // },
      body: lgn.toJson(),
    );

    if (resp.statusCode == 200) {
      print(resp.body);
      Users user1 = Users.fromJson(json.decode(resp.body));
      print(user1);
      return user1; //Users.fromJson(user);
    } else {
      return user;
    }
  }
}
