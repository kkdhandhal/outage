import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/feeder.dart';

class API {
  static Future<List<Feeder>> fetchFeederData(String srch) async {
    var url;
    if (srch.length > 0) {
      url = Uri.parse('http://192.168.0.101:3000/api/feeder/list/search/$srch');
    } else {
      url = Uri.parse('http://192.168.0.101:3000/api/feeder/list/');
    }

    var body = json.encode({"fdr_string": srch});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((feeder) => Feeder.fromJson(feeder)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
