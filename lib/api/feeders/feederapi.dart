import 'dart:convert';

import 'package:outage/model/feeder.dart';
import 'package:http/http.dart' as http;
// import 'package:outage/model/login/logreqmod.dart';
import 'package:outage/utils/constants.dart';

class FeederAPI {
  static Future<List<Feeder>> getSDNFeeders(String userCode) async {
    String bodyStr = '{"APIKEY":$getFeeders_APIKEY,"USRCODE":"$userCode"}';
    var url = Uri.parse(getFeeders_url);
    //Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    //var body = json.encode({"fdr_string": srch});
    print(url);
    try {
      Map<String, String> userHeader = {
        "Content-Type": "application/json",
      };
      final response = await http.post(url, headers: userHeader, body: bodyStr);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
      } else {
        List<Feeder> fdrErr = [
          Feeder(
              fdr_code: response.statusCode,
              fdr_name: response.statusCode.toString(),
              fdr_category: "",
              fdr_cons: 0)
        ];
        return fdrErr;
      }
    } catch (e) {
      List<Feeder> fdrErr = [
        Feeder(
            fdr_code: -2, fdr_name: e.toString(), fdr_category: "", fdr_cons: 0)
      ];
      return fdrErr;
    }
  }
}
