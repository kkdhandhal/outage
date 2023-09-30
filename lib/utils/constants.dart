import 'package:flutter/material.dart';

const kBackgraoundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF2D5D70);
const kSecondaryColor = Color(0xFF265DAB);

//const homeIP = "192.168.0.101";
const officeIP = "117.205.3.45"; //"192.168.0.101"; //"10.35.152.22";
const port = "8083";

const realmSchemaVersion = 2;
const dbname = "outage";
const application_no = 1;
// http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/
String loginValidateurl =
    "http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/";
// "http://$officeIP:$port/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/";

String otpValidateurl =
    "http://$officeIP:$port/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateOTP/OTP/";
const loginOTP_APIKEY = "pgvclit001002apiloginotp-";
const loginVAL_APIKEY = "pgvclit001001apiloginval-";
