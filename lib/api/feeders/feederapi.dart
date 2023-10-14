import 'dart:convert';

import 'package:outage/model/feeder.dart';
import 'package:http/http.dart' as http;
import 'package:outage/model/login/logreqmod.dart';
// import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/utils/constants.dart';

class FeederAPI {
  static Future<List<dynamic>> getSDNFeeders(String userCode) async {
    String bodyStr = '[{"APIKEY":"$getFeeders_APIKEY","USRCODE":"$userCode"}]';
    var url = Uri.parse(getFeedersurl);
    //Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    //var body = json.encode({"fdr_string": srch});
    print(url);
    try {
      Map<String, String> userHeader = {
        "Content-Type": "application/json",
      };
      final response = await http.post(url, headers: userHeader, body: bodyStr);
      if (response.statusCode == 200) {
        String jsonResponce = response.body.replaceAll("\\", "");
        jsonResponce = jsonResponce.replaceAll("null", '"*"');
        jsonResponce = jsonResponce.replaceAll("\"[", "[");
        jsonResponce = jsonResponce.replaceAll("]\"", "]");
        //
        if (jsonResponce.contains('{"Status":')) {
          List<LoginResponse> responce = [
            LoginResponse.fromJson(json.decode(jsonResponce))
          ];
          return responce;
        } else {
          List jsonResponse = json.decode(jsonResponce);
          return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
        }
      } else {
        List<Feeder> fdrErr = [
          Feeder(
              FeederCode: response.statusCode,
              FeederName: response.statusCode.toString(),
              FeederCategory: "",
              fdr_cons: 0)
        ];
        return fdrErr;
      }
    } catch (e) {
      List<Feeder> fdrErr = [
        Feeder(
            FeederCode: -2,
            FeederName: e.toString(),
            FeederCategory: "",
            fdr_cons: 0)
      ];
      return fdrErr;
    }
  }
}
