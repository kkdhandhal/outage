class Feeder {
  // final int fdr_loccode;
  // final int fdr_adm_sdn;
  final int fdr_code;
  // final String fdr_type;
  final String fdr_name;
  final String fdr_category;
  final int fdr_cons;

  Feeder({
    // required this.fdr_loccode,
    // required this.fdr_adm_sdn,
    required this.fdr_code,
    // required this.fdr_type,
    required this.fdr_name,
    required this.fdr_category,
    required this.fdr_cons,
  });

  factory Feeder.initFeeder() {
    return Feeder(
        // fdr_loccode: 0,
        // fdr_adm_sdn: 0,
        fdr_code: 0,
        fdr_cons: 0,
        // fdr_type: "",
        fdr_name: "",
        fdr_category: "");
  }

  Map<String, dynamic> toJson() {
    return ({
      // 'fdr_loccode': fdr_loccode,
      // 'fdr_adm_sdn': fdr_adm_sdn,
      'fdr_code': fdr_code,
      // 'fdr_type': fdr_type,
      'fdr_name': fdr_name,
      'fdr_category': fdr_category,
      'fdr_cons': fdr_cons,
    });
  }

  factory Feeder.fromJson(Map<String, dynamic> json) {
    return Feeder(
        // fdr_loccode: json['fdr_loccode'],
        // fdr_adm_sdn: json['fdr_adm_sdn'],
        fdr_code: json['FeederCode'],
        fdr_cons: 0,
        // fdr_type: json['fdr_type'],
        fdr_name: json['FeederName'],
        fdr_category: json['FeederCategory']);
  }
}
