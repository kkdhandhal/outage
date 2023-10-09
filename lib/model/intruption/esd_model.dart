import 'package:intl/intl.dart';
import 'package:outage/utils/constants.dart';

class ESDList {
  final int FeederCode;
  final String FeederName;
  final String FeederCategory;
  final DateTime ESDFrom;
  final DateTime ESDTo;

  final int ConsumersAffected;
  final int TotalSMSSent;

  ESDList({
    //required this.esd_id,
    required this.FeederCode,
    required this.FeederName,
    required this.FeederCategory,
    required this.ESDFrom,
    required this.ESDTo,
    required this.ConsumersAffected,
    required this.TotalSMSSent,
  });

  Map<String, dynamic> toJson() {
    return ({
      'FeederCode': FeederCode,
      'FeederName': FeederName,
      'FeederCategory': FeederCategory,
      'ESDFrom': ESDFrom.toIso8601String(),
      'ESDTo': ESDTo.toIso8601String(),
      'ConsumersAffected': ConsumersAffected,
      'TotalSMSSent': TotalSMSSent,
    });
  }

  factory ESDList.fromJson(Map<String, dynamic> json) {
    return ESDList(
      //esd_id: json['_id'],
      FeederCode: json['FeederCode'],
      FeederName: json['FeederName'],
      FeederCategory: json['FeederCategory'],
      ESDFrom: DateFormat('yyyy-MM-dd').parse(json['ESDFrom']),
      ESDTo: DateFormat('yyyy-MM-dd').parse(json['ESDTo']),
      ConsumersAffected: json['ConsumersAffected'],
      TotalSMSSent: json['TotalSMSSent'],
    );
  }
}

class ESD {
  //String esd_id = "";
  final String APIKEY;
  final String entry_type;
  final String USRCODE;
  final int FEEDERCD;
  final String FEEDERCATEGORY;
  final String FEEDERNM;
  final DateTime ESDDATE;
  final DateTime ESDENDDATE;

  final String ESDFROMHH;
  final String ESDFROMMM;
  final String ESDTOHH;
  final String ESDTOMM;

  final int ESDDURATIONHH;
  final int ESDDURATIONMM;
  // final int esd_cons_affected;
  // final int TotalSMSSent;
  final String ESDREASON;
  final String ESDCORRECTACTION;
  final String ESDLCTAKENBY;
  final DateTime ENTRYDATE;

  final String IPIMEI;

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
    required this.APIKEY,
    required this.entry_type,
    required this.USRCODE,
    required this.FEEDERCD,
    required this.FEEDERCATEGORY,
    required this.FEEDERNM,
    required this.ESDDATE,
    required this.ESDENDDATE,
    required this.ESDFROMHH,
    required this.ESDFROMMM,
    required this.ESDTOHH,
    required this.ESDTOMM,
    required this.ESDDURATIONHH,
    required this.ESDDURATIONMM,
    // required this.esd_cons_affected,
    // required this.TotalSMSSent,
    required this.ESDREASON,
    required this.ESDCORRECTACTION,
    required this.ESDLCTAKENBY,
    required this.ENTRYDATE,
    required this.IPIMEI,
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
  List<Map<String, dynamic>> toJson() {
    return ([
      {
        '"APIKEY"': '"$saveESD_APIKEY"',
        '"entry_type"': '"$entry_type"',
        '"USRCODE"': '"$USRCODE"',
        '"FEEDERCD"': '"$FEEDERCD"',
        '"FEEDERCATEGORY"': '"$FEEDERCATEGORY"',
        '"FEEDERNM"': '"$FEEDERNM"',
        '"ESDDATE"': '"${ESDDATE.toIso8601String()}"',
        '"ESDENDDATE"': '"${ESDENDDATE.toIso8601String()}"',
        '"ESDFROMHH"': '"$ESDFROMHH"',
        '"ESDFROMMM"': '"$ESDFROMMM"',
        '"ESDTOMM"': '"$ESDTOMM"',
        '"ESDTOHH"': '"$ESDTOHH"',
        '"ESDDURATIONHH"': '"$ESDDURATIONHH"',
        '"ESDDURATIONMM"': '"$ESDDURATIONMM"',
        // 'esd_cons_affected': esd_cons_affected,
        '"ESDCORRECTACTION"': '"$ESDCORRECTACTION"',
        '"ESDREASON"': '"$ESDREASON"',
        '"ESDLCTAKENBY"': '"$ESDLCTAKENBY"',
        '"ENTRYDATE"': '"${ENTRYDATE.toIso8601String()}"',
        '"IPIMEI"': '"$IPIMEI"',
      }
    ]);
  }

  factory ESD.fromJson(Map<String, dynamic> json) {
    return ESD(
      APIKEY: "",
      entry_type: json['entry_type'],
      USRCODE: json['USRCODE'],
      FEEDERCD: json['FEEDERCD'],
      FEEDERCATEGORY: json['FEEDERCATEGORY'],
      FEEDERNM: json['FEEDERNM'],
      ESDDATE: DateFormat('yyyy-MM-dd').parse(json['ESDDATE']),
      ESDENDDATE: DateFormat('yyyy-MM-dd').parse(json['ESDENDDATE']),
      ESDFROMHH: json['ESDFROMHH'],
      ESDFROMMM: json['ESDFROMMM'],
      ESDTOMM: json['ESDTOMM'],
      ESDTOHH: json['ESDTOHH'],
      ESDDURATIONHH: json['ESDDURATIONHH'],
      ESDDURATIONMM: json['ESDDURATIONMM'],
      // esd_cons_affected: json['esd_cons_affected'],

      ESDCORRECTACTION: json['ESDCORRECTACTION'],
      ESDREASON: json['ESDREASON'],
      ESDLCTAKENBY: json['ESDLCTAKENBY'],
      ENTRYDATE: DateFormat('yyyy-MM-dd')
          .parse(json['ENTRYDATE']), //DateTime(json['esd_end_date']),

      IPIMEI: json['IPIMEI'],
    );
  }
}
