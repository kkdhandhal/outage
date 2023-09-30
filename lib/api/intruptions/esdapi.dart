import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:outage/model/api_gen_res.dart';
import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/utils/constants.dart';

class ESDAPI {
  static Future<APIResult> entryESD(ESD esd) async {
    if (kDebugMode) {
      print("ESD detail :  ${esd.toJson()}");
    }

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

  static Future<List<ESD>> fetchESD(int esd_fdr_code) async {
    //print("ESD detail :  ${esd.toJson()}");

    var url = Uri.parse(
        'http://$officeIP:3000/api/intruption/esd/list/$esd_fdr_code');
    print("URL: $url");
    final resp = await http.get(
      url,
    );
    List<ESD> esd1 = [];
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      List jsonResponse = json.decode(resp.body);
      print(jsonResponse);
      return jsonResponse.map((esd) => ESD.fromJson(esd)).toList();
      // print(esd1[0].esd_fdr_code);
      //return esd1;
    } else {
      return esd1;
    }
  }
}
