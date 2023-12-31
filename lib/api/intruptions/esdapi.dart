import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:outage/model/intruption/esd_model.dart';
import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/utils/constants.dart';

class ESDAPI {
  static Future<LoginResponse> entryESD(ESD esd) async {
    if (kDebugMode) {
      print("ESD detail :  ${esd.toJson()}");
    }
    // List<ESD> esdList = [esd]
    var url = Uri.parse(saveESD);
    print("URL: $url --- ${esd.toJson().toString()}");
    String bodyString = esd.toJson().toString();
    final resp = await http.post(
      url,
      headers: <String, String>{
        'content-type': 'application/json',
      },
      body: bodyString, //jsonEncode(esd.toJson()),
      // body: jsonEncode(esd.toJson()),
    );
    //print("Request send: ${esd.toJson()}");
    if (resp.statusCode == 200) {
      String jsonResponce = resp.body.replaceAll("\\", "");
      jsonResponce = jsonResponce
          .replaceAll("null", '"*"')
          .replaceAll("\"{", "{")
          .replaceAll("}\"", "}");
      print(jsonResponce);
      LoginResponse esd1 = LoginResponse.fromJson(json.decode(jsonResponce));
      print(esd1);
      return esd1;
    } else {
      LoginResponse resError = LoginResponse(
          Location_code: "",
          Location_name: "",
          Status: resp.statusCode,
          Status_message: "API Responce Error Code $resp.statusCode",
          User_name: "");
      return resError;
    }
  }

  static Future<List<dynamic>> fetchESD(String userCode) async {
    //print("ESD detail :  ${esd.toJson()}");fetchESD_APIKEY
    String bodyStr = '[{"APIKEY":"$fetchESD_APIKEY","USRCODE":"$userCode"}]';
    var url = Uri.parse(fetchESDurl);
    try {
      Map<String, String> userHeader = {
        "Content-Type": "application/json",
      };
      final resp = await http.post(url, headers: userHeader, body: bodyStr);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        String jsonResponce = resp.body.replaceAll("\\", "");
        print(
            "\n URL is $url -----  \n Body is : $bodyStr   \n Responce Body is : ${resp.body}");
        jsonResponce = jsonResponce
            .replaceAll("null", '"*"')
            .replaceAll("\"{", "{")
            .replaceAll("}\"", "}");
        if (jsonResponce.contains('{"Status":')) {
          List<LoginResponse> responce = [
            LoginResponse.fromJson(json.decode(jsonResponce))
          ];

          return responce;
        } else {
          print(jsonResponce);
          List jsonRes = json.decode(jsonResponce);

          return jsonRes.map((esd) => ESDList.fromJson(esd)).toList();
        }

        // print(esd1[0].esd_fdr_code);
        //return esd1;
      } else {
        List<LoginResponse> responce = [
          LoginResponse(
              Status: resp.statusCode,
              Status_message: "API Response Error",
              User_name: "",
              Location_name: "",
              Location_code: "")
        ];
        return responce;
      }
    } catch (e) {
      List<LoginResponse> responce = [
        LoginResponse(
            Status: -2,
            Status_message: e.toString(),
            User_name: "",
            Location_name: "",
            Location_code: "")
      ];
      return responce;
    }
  }
}
