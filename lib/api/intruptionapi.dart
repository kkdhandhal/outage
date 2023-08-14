import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:outage/model/api_gen_res.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/rlmfeeder.dart';
import 'package:realm/realm.dart';
import '../model/user.dart';
import 'package:outage/utils/constants.dart';

class IntruptionAPI {
  static Future<APIResult> entryESD(ESD esd) async {
    print("ESD detail :  ${esd.toJson()}");

    var url = Uri.parse('http://$officeIP:3000/api/intruption/esd/create');
    print("URL: $url");
    final resp = await http.post(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
      },
      body: jsonEncode(esd.toJson()),
    );
    print("Request send: ${esd.toJson()}");
    //if (resp.statusCode == 200) {
    print(resp.body);
    APIResult esd1 = APIResult.fromJson(json.decode(resp.body));
    print(esd1);
    return esd1; //Users.fromJson(user);
    // } else {
    //   print(resp.body);
    //   APIResult esd1 = APIResult.fromJson(json.decode(resp.body));
    //   print(esd1);
    //   return esd1;
    // }
  }

  static Future<APIResult> fetchESD(ESD esd) async {
    print("ESD detail :  ${esd.toJson()}");

    var url = Uri.parse('http://$officeIP:3000/api/intruption/esd/create');
    print("URL: $url");
    final resp = await http.post(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
      },
      body: jsonEncode(esd.toJson()),
    );
    print("Request send: ${esd.toJson()}");
    //if (resp.statusCode == 200) {
    print(resp.body);
    APIResult esd1 = APIResult.fromJson(json.decode(resp.body));
    print(esd1);
    return esd1; //Users.fromJson(user);
    // } else {
    //   print(resp.body);
    //   APIResult esd1 = APIResult.fromJson(json.decode(resp.body));
    //   print(esd1);
    //   return esd1;
    // }
  }
}
