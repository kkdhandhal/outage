class Feeder {
  final int fdr_loccode;
  final int fdr_adm_sdn;
  final int fdr_code;
  final String fdr_type;
  final String fdr_name;
  final String fdr_category;

  Feeder({
    required this.fdr_loccode,
    required this.fdr_adm_sdn,
    required this.fdr_code,
    required this.fdr_type,
    required this.fdr_name,
    required this.fdr_category,
  });

  factory Feeder.initFeeder() {
    return Feeder(
        fdr_loccode: 0,
        fdr_adm_sdn: 0,
        fdr_code: 0,
        fdr_type: "",
        fdr_name: "",
        fdr_category: "");
  }

  factory Feeder.fromJson(Map<String, dynamic> json) {
    return Feeder(
        fdr_loccode: json['fdr_loccode'],
        fdr_adm_sdn: json['fdr_adm_sdn'],
        fdr_code: json['fdr_code'],
        fdr_type: json['fdr_type'],
        fdr_name: json['fdr_name'],
        fdr_category: json['fdr_category']);
  }
}
