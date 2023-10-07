class Feeder {
  // final int fdr_loccode;
  // final int fdr_adm_sdn;
  final int FeederCode;
  // final String fdr_type;
  final String FeederName;
  final String FeederCategory;
  final int fdr_cons;

  Feeder({
    // required this.fdr_loccode,
    // required this.fdr_adm_sdn,
    required this.FeederCode,
    // required this.fdr_type,
    required this.FeederName,
    required this.FeederCategory,
    required this.fdr_cons,
  });

  factory Feeder.initFeeder() {
    return Feeder(
        // fdr_loccode: 0,
        // fdr_adm_sdn: 0,
        FeederCode: 0,
        fdr_cons: 0,
        // fdr_type: "",
        FeederName: "",
        FeederCategory: "");
  }

  Map<String, dynamic> toJson() {
    return ({
      // 'fdr_loccode': fdr_loccode,
      // 'fdr_adm_sdn': fdr_adm_sdn,
      'FeederCode': FeederCode,
      // 'fdr_type': fdr_type,
      'FeederName': FeederName,
      'FeederCategory': FeederCategory,
      'fdr_cons': fdr_cons,
    });
  }

  factory Feeder.fromJson(Map<String, dynamic> json) {
    return Feeder(
        // fdr_loccode: json['fdr_loccode'],
        // fdr_adm_sdn: json['fdr_adm_sdn'],
        FeederCode: json['FeederCode'],
        fdr_cons: 0,
        // fdr_type: json['fdr_type'],
        FeederName: json['FeederName'],
        FeederCategory: json['FeederCategory']);
  }
}
