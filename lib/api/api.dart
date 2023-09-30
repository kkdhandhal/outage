import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:outage/model/feeder.dart';
import 'package:outage/utils/constants.dart';

class API {
  static Future<List<Feeder>> fetchFeederData(
      String srch, String adm_sdn_code) async {
    var url;
    if (srch.length > 0) {
      url = Uri.parse(
          'http://$officeIP:3000/api/feeder/list/$adm_sdn_code/search/$srch');
    } else {
      url = Uri.parse('http://$officeIP:3000/api/feeder/list/$adm_sdn_code');
    }

    //var body = json.encode({"fdr_string": srch});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<List<Feeder>> getSDNFeeders(String adm_sdn_code) async {
    // var url;
    // if (srch.length > 0) {
    //   url = Uri.parse(
    //       'http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code/search/$srch');
    // } else {
    //   url = Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    // }
    var url = Uri.parse('http://$officeIP:3000/api/feeder/list/$adm_sdn_code');
    //Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    //var body = json.encode({"fdr_string": srch});
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
