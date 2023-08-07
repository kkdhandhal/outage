import 'dart:convert';

import 'package:http/http.dart' as http;

class Feeder {
  final int fdr_company;
  final int fdr_circle;
  final int fdr_divsion;
  final String fdr_ss;
  final int fdr_sdn;
  final int fdr_code;
  final String fdr_name;
  final String fdr_category;

  Feeder({
    required this.fdr_code,
    required this.fdr_company,
    required this.fdr_circle,
    required this.fdr_divsion,
    required this.fdr_ss,
    required this.fdr_sdn,
    required this.fdr_name,
    required this.fdr_category,
  });

  factory Feeder.fromJson(Map<String, dynamic> json) {
    return Feeder(
        fdr_code: json['fdr_code'],
        fdr_company: json['fdr_company'],
        fdr_circle: json['fdr_circle'],
        fdr_divsion: json['fdr_divsion'],
        fdr_ss: json['fdr_ss'],
        fdr_sdn: json['fdr_sdn'],
        fdr_name: json['fdr_name'],
        fdr_category: json['fdr_category']);
  }
}
