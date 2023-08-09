import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outage/model/rlmfeeder.dart';
import 'package:realm/realm.dart';
import '../model/feeder.dart';
import 'package:outage/utils/constants.dart';

class API {
  static Future<RealmResults<rlmfeeder>> rlm_fetchFeederData(
      String srch, int admSdnCode, Realm realm) async {
    if (srch.length > 0) {
      //final realm = Realm(Configuration.local([rlmfeeder.schema]));
      print("realm variable generated");
      // var rlmResult = realm.query<rlmfeeder>(
      //     "fdr_name contains $srch AND fdr_loccode==$admSdnCode");
      print("fdr_name CONTAINS $srch");

      var rlmResult =
          realm.query<rlmfeeder>("fdr_name CONTAINS[c] \$0", [srch]);
      print("realm result $rlmResult");
      return rlmResult;
    } else {
      final realm = Realm(Configuration.local([rlmfeeder.schema]));
      print("realm variable generated");
      // var rlmResult = realm.query<rlmfeeder>(
      //     "fdr_name contains $srch AND fdr_loccode==$admSdnCode");
      final rlmResult = realm.all<rlmfeeder>();
      print("realm result $rlmResult");
      return rlmResult;
    }
  }

  static Future<List<Feeder>> fetchFeederData(
      String srch, int adm_sdn_code) async {
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

  static Future<List<Feeder>> getSDNFeeders(int adm_sdn_code) async {
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
