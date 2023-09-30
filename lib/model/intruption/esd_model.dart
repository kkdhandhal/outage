import 'package:intl/intl.dart';

class ESD {
  //String esd_id = "";

  final int esd_fdr_code;
  final DateTime esd_st_date;
  final String esd_st_time;
  final DateTime esd_end_date;
  final String esd_end_time;
  final int esd_duration;
  final int esd_cons_affected;
  final String esd_reason;
  final String esd_action;
  final String esd_lc_by;
  final DateTime esd_cre_date;
  final String created_by;

  //  esd_id: req.body.esd_id,
  //   esd_fdr_code: req.body.esd_fdr_code,
  //   esd_st_date: req.body.esd_st_date,
  //   esd_st_time: req.body.esd_st_time,
  //   esd_end_date: req.body.esd_end_date,
  //   esd_end_time: req.body.esd_end_time,
  //   esd_duration: req.body.esd_duration,
  //   esd_cons_affected: req.body.esd_cons_affected,
  //   esd_reason: req.body.esd_reason,
  //   esd_action: req.body.esd_action,
  //   esd_lc_by: req.body.esd_lc_by

  ESD({
    //required this.esd_id,
    required this.esd_fdr_code,
    required this.esd_st_date,
    required this.esd_st_time,
    required this.esd_end_date,
    required this.esd_end_time,
    required this.esd_duration,
    required this.esd_cons_affected,
    required this.esd_reason,
    required this.esd_action,
    required this.esd_lc_by,
    required this.esd_cre_date,
    required this.created_by,
  });

  // factory Feeder.initFeeder() {
  //   return Feeder(
  //       fdr_loccode: 0,
  //       fdr_adm_sdn: 0,
  //       fdr_code: 0,
  //       fdr_type: "",
  //       fdr_name: "",
  //       fdr_category: "");
  // }
  Map<String, dynamic> toJson() {
    return ({
      'esd_fdr_code': esd_fdr_code,
      'esd_st_date': esd_st_date.toIso8601String(),
      'esd_st_time': esd_st_time,
      'esd_end_date': esd_end_date.toIso8601String(),
      'esd_end_time': esd_end_time,
      'esd_duration': esd_duration,
      'esd_cons_affected': esd_cons_affected,
      'esd_reason': esd_reason,
      'esd_action': esd_action,
      'esd_lc_by': esd_lc_by,
      'esd_cre_date': esd_cre_date.toIso8601String(),
      'created_by': created_by,
    });
  }

  factory ESD.fromJson(Map<String, dynamic> json) {
    return ESD(
        //esd_id: json['_id'],
        esd_fdr_code: json['esd_fdr_code'],
        esd_st_date: DateFormat('yyyy-MM-dd').parse(json['esd_st_date']),
        esd_st_time: json['esd_st_time'],
        esd_end_date: DateFormat('yyyy-MM-dd')
            .parse(json['esd_end_date']), //DateTime(json['esd_end_date']),
        esd_end_time: json['esd_end_time'],
        esd_duration: json['esd_duration'],
        esd_cons_affected: json['esd_cons_affected'],
        esd_reason: json['esd_reason'],
        esd_action: json['esd_action'],
        esd_lc_by: json['esd_lc_by'],
        esd_cre_date: DateFormat('yyyy-MM-dd').parse(json['esd_cre_date']),
        created_by: json['created_by']);
  }
}
