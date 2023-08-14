class APIResult {
  final int db_code;
  final String db_msg;

  APIResult({
    required this.db_code,
    required this.db_msg,
  });

  factory APIResult.fromJson(Map<String, dynamic> json) {
    return APIResult(db_code: json['db_code'] as int, db_msg: json['db_msg']);
  }
}
