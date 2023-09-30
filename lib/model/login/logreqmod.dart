import 'package:outage/utils/constants.dart';

class LoginBase {
  final String apiKey = loginOTP_APIKEY;
  final int appNo = application_no;
  final String imei;
  LoginBase({required this.imei});
}

class OTPReq extends LoginBase {
  final String usrCode;
  final int otp;

  OTPReq({required this.usrCode, required super.imei, required this.otp});

  Map<String, dynamic> toJson() {
    return ({
      "APIKEY": apiKey,
      "USRCODE": usrCode,
      "APPNO": appNo,
      "IMEI": imei,
      "OTP": otp,
    });
  }
}

class LoginReq extends LoginBase {
  final String usrCode;
  final String usrPass;

  LoginReq({
    required this.usrCode,
    required this.usrPass,
    required super.imei,
  });

  List<Map<String, dynamic>> toJson() {
    return ([
      {
        '"APIKEY"': '"$loginVAL_APIKEY"',
        '"USRCODE"': '"$usrCode"',
        '"USRPASS"': '"$usrPass"',
        '"APPNO"': '"$appNo"',
        '"IMEI"': '"$imei"',
      }
    ]);
  }
}

class LoginResponse {
  final int Status;
  final String Status_message;
  final String User_name;
  final String Location_name;
  final String Location_code;

  LoginResponse(
      {required this.Status,
      required this.Status_message,
      required this.User_name,
      required this.Location_name,
      required this.Location_code});

  Map<String, dynamic> toJson() {
    return ({
      "Status": Status,
      "Status_message": Status_message,
      "User_name": User_name,
      "Location_name": Location_name,
      "Location_code": Location_code
    });
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      Status: int.parse(json['Status']),
      Status_message: json['Status_message'],
      User_name: json['User_name'],
      Location_name: json['Location_name'],
      Location_code: json['Location_code'],
    );
  }
}
