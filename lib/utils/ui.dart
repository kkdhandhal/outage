import 'package:flutter/material.dart';

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
//const Color appSecondaryBtnColor = Color.fromARGB(255, 8, 135, 238);
const Color appSecondaryBtnColor = Color.fromARGB(255, 113, 80, 231);

TextStyle dlgTitle(Color dlgTitleColor) {
  return TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: dlgTitleColor,
  );
}

TextStyle dlgBtnText() {
  return const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: appPrimaryWhiteText,
  );
}

TextStyle dlgText() {
  return const TextStyle(
    fontSize: 15,
    color: appPrimaryWhiteText,
  );
}

TextStyle dlgSubText() {
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: appPrimaryWhiteText,
  );
}
