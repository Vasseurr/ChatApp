import 'package:flutter/material.dart';

class ColorSchemeLight {
  static late ColorSchemeLight _instance;
  static ColorSchemeLight get instance {
    _instance = ColorSchemeLight._init();
    return _instance;
  }

  ColorSchemeLight._init();

  final Color backgroundColor = Colors.white;

  //* bottom bar
  final Color bottomBarUnselectedIconColor = const Color(0xffacacac);
  final Color bottomBarSelectedIconColor =
      const Color.fromRGBO(51, 128, 124, 1);
  //final Color bottomBarBackgroundColor = const Color.fromRGBO(31, 27, 46, 1);
  final Color bottomBarBackgroundColor = Colors.green.shade800;

  //* card
  final Color colorGreen = const Color.fromRGBO(129, 213, 64, 1);
  final Color darkColorGreen = const Color.fromARGB(255, 77, 134, 33);
  final Color cardColorGreen = const Color.fromRGBO(51, 128, 124, 1);
  final Color purpleCard = const Color.fromRGBO(242, 235, 254, 1);
  final Color orangeCard = const Color.fromRGBO(255, 238, 234, 1);
  final Color petCardColor = const Color.fromARGB(255, 120, 197, 172);
  final Color petCardColor2 = const Color.fromARGB(255, 65, 177, 93);

  final Color colorBlue = const Color(0xFF00C6B8);
  final Color colorSolidBlack = const Color(0xFF393e46);
  final Color colorBlack = const Color(0xFF222831);
  final Color colorWhite = const Color(0xFFeeeeee);
//  final Color colorGrey = Color(0xFFeeeeee);

  final Color colorLightGrey = const Color.fromRGBO(247, 247, 248, 1);
  final Color customPurple = const Color.fromRGBO(134, 54, 247, 1);
  final Color customGrey = const Color.fromRGBO(199, 198, 211, 1);
  final Color customLightGrey = const Color.fromARGB(255, 243, 237, 237);
  final Color customOrange = const Color.fromRGBO(254, 100, 58, 1);
  final Color customDarkBlue = const Color.fromRGBO(114, 120, 227, 1);
  final Color customLightBlue = const Color.fromARGB(255, 210, 218, 226);
  final Color customGreen = const Color.fromRGBO(120, 212, 185, 1);
  final Color customPink = const Color.fromRGBO(211, 118, 175, 1);
  final Color customDarkPink = const Color.fromRGBO(243, 71, 157, 1);
}
