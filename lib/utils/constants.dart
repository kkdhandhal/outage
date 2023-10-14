import 'package:flutter/material.dart';

const kBackgraoundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF2D5D70);
const kSecondaryColor = Color(0xFF265DAB);

//const homeIP = "192.168.0.101";
const officeIP = "117.205.3.45"; //"192.168.0.101"; //"10.35.152.22";
const port = "8083";

const realmSchemaVersion = 2;
const dbname = "outage";
const application_no = 6;
// http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/
String loginValidateurl =
    "http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateLogin/Login/";
String otpValidateurl =
    "http://117.205.3.45:8083/PGVCLITAPPAPI/PGVCLITAPPAPI/ValidateOTP/OTP/";
String fetchESDurl =
    "http://117.205.3.45:8083/PGVCLITAPPAPI/ESD/fetchESD/FetchESD/";
String getFeedersurl =
    "http://117.205.3.45:8083/PGVCLITAPPAPI/ESD/getFeeders/Feeders/";
String saveESD = "http://117.205.3.45:8083/PGVCLITAPPAPI/ESD/saveESD/SaveESD/";

const getFeeders_APIKEY = "pgvclit002001apigetfdrs--";
const fetchESD_APIKEY = "pgvclit002003apifetchESD-";
const loginOTP_APIKEY = "pgvclit001002apiloginotp-";
const loginVAL_APIKEY = "pgvclit001001apiloginval-";
const saveESD_APIKEY = "pgvclit002002apisaveESD--";
const appVersionNo = "Beta (1.0.0) ";

const Color appPrimaryColor = Color.fromARGB(255, 69, 48, 145);
const Color appSecondaryColor = Colors.blue;
const Color appThirdColor = Colors.white;
const Color appPrimaryColorLowShade = Color.fromARGB(255, 218, 211, 247);

const Color appAlertColor = Color.fromARGB(251, 253, 114, 72);
const Color appSucessColor = Color.fromARGB(250, 154, 226, 140);

const Color appPrimaryTextColor = Colors.white;
const Color appPrimaryWhiteText = Colors.white;
const Color appPrimaryBlackText = Color.fromARGB(255, 52, 56, 59);
const Color appSecondaryTextColor = Color.fromARGB(255, 169, 156, 218);

const Color appPrimaryBtnColor = Color.fromARGB(255, 121, 99, 199);
const Color appSecondaryBtnColor = Color.fromARGB(255, 8, 135, 238);
