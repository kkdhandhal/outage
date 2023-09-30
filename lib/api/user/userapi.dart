import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:outage/model/login/logreqmod.dart';

import 'package:outage/utils/constants.dart';

class UserAPI {
  static Future<LoginResponse> checkLogin(LoginReq lgnreq) async {
    var url = Uri.parse(loginValidateurl);
    print("login detail  ${lgnreq.toJson().toString()} and url is $url");
    String bodyStr = lgnreq.toJson().toString();
    print("JsonObject is : $bodyStr");

    try {
      Map<String, String> userHeader = {
        "Content-Type": "application/json",
      };
      final resp = await http.post(
        url,
        // Uri.parse(
        //     "http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/"),
        headers: userHeader,
        body: bodyStr,
      );
      print("Request Send");
      print("Response Code is : $resp.statusCode");
      if (resp.statusCode == 200) {
        String json_string = resp.body.replaceAll("null", '"*"');
        // json_string = json_string.replaceAll("{", '').toString();
        // json_string = json_string.replaceAll("}", '').toString();
        print(json_string);
        LoginResponse log_resp =
            LoginResponse.fromJson(jsonDecode(json_string));
        print(log_resp);
        return log_resp; //Users.fromJson(user);
      } else {
        return LoginResponse(
            Status: resp.statusCode,
            Status_message: resp.statusCode.toString(),
            User_name: "",
            Location_name: "",
            Location_code: "");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return LoginResponse(
          Status: -1,
          Status_message: e.toString(),
          User_name: "",
          Location_code: "",
          Location_name: "");
    }
  }
}
