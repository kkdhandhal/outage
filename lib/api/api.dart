import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outage/model/rlmfeeder.dart';
import 'package:realm/realm.dart';
import '../model/feeder.dart';

class API {
  static Future<List<rlmfeeder>> rlm_fetchFeederData(
      String srch, int adm_sdn_code) async {
    final realm = Realm(Configuration.local([rlmfeeder.schema]));
    var rlmResult =
        realm.query("fdr_name contains $srch AND fdr_adm_sdn=$adm_sdn_code");
    List<rlmfeeder> fdr = rlmResult as List<rlmfeeder>;
    return fdr;

    // var url;
    // if (srch.length > 0) {
    //   url = Uri.parse(
    //       'http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code/search/$srch');
    // } else {
    //   url = Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    // }

    //var body = json.encode({"fdr_string": srch});
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   List jsonResponse = json.decode(response.body);
    //   return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
    // } else {
    //   throw Exception('Unexpected error occured!');
    // }
  }

  static Future<List<Feeder>> fetchFeederData(
      String srch, int adm_sdn_code) async {
    var url;
    if (srch.length > 0) {
      url = Uri.parse(
          'http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code/search/$srch');
    } else {
      url = Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
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

  static Future<List<Feeder>> getSDNFeeders(int adm_sdn_code) async {
    // var url;
    // if (srch.length > 0) {
    //   url = Uri.parse(
    //       'http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code/search/$srch');
    // } else {
    //   url = Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    // }
    var url =
        Uri.parse('http://10.35.152.22:3000/api/feeder/list/$adm_sdn_code');
    //var body = json.encode({"fdr_string": srch});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
