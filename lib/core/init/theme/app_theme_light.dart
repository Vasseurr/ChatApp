import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors.dart';
import '../../constants/text_constants.dart';
import 'app_theme.dart';
import 'light/color_scheme_light.dart';
import 'light/light_theme_interface.dart';
import 'panache/pet_park_theme.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static late AppThemeLight _instance;
  static AppThemeLight get instance {
    _instance = AppThemeLight._init();

    return _instance;
  }

  AppThemeLight._init();

  @override
  ColorSchemeLight get colorSchemeLight => ColorSchemeLight.instance;

  ThemeData get customTheme => petParkTheme;

  // ThemeData get theme => redTheme;
  @override
  ThemeData get theme => ThemeData(
          primaryColor: _appColorScheme().primary,
          primaryColorLight: Colors.black,
          cardColor: ColorSchemeLight.instance.colorGreen,
          fontFamily: AppConstants.FONT_FAMILY,
          textTheme: GoogleFonts.comfortaaTextTheme(),
          canvasColor: Colors.transparent,
          appBarTheme: _appBarTheme(),
          buttonTheme:
              ButtonThemeData(buttonColor: colorSchemeLight.colorWhite),
          primaryIconTheme: IconThemeData(color: colorSchemeLight.colorWhite),
          // scaffoldBackgroundColor: ColorSchemeLight.instance.colorGreen,
          scaffoldBackgroundColor: Colors.white,
          iconTheme: IconThemeData(color: ColorSchemeLight.instance.colorWhite)
              .copyWith(),
          floatingActionButtonTheme:
              ThemeData.light().floatingActionButtonTheme.copyWith(),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor:
                ColorSchemeLight.instance.bottomBarSelectedIconColor,
            unselectedItemColor:
                ColorSchemeLight.instance.bottomBarUnselectedIconColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
              color: ColorSchemeLight.instance.colorLightGrey),
          colorScheme: _appColorScheme()
              .copyWith(background: MyColors.greyBackgroundColor)
          //     tabBarTheme: tabBarTheme(),
          )
      .copyWith();

  TextTheme textTheme() {
    return TextTheme(
        displayLarge: textThemeLight.headline1,
        displayMedium: textThemeLight.headline2,
        labelSmall: textThemeLight.headline3);
  }

  ColorScheme _appColorScheme() {
    return ColorScheme(
        primary: Colors.white,
        secondary: colorSchemeLight.colorBlack,
        surface: Colors.white,
        background: colorSchemeLight.colorBlue,
        onPrimary: const Color.fromRGBO(219, 163, 154, 1),
        onSecondary: const Color.fromRGBO(245, 164, 15, 1),
        onSurface: const Color.fromRGBO(73, 85, 121, 1),
        onBackground: Colors.black12,
        onError: const Color.fromRGBO(228, 100, 69, 1),
        brightness: Brightness.light,
        tertiary: const Color.fromRGBO(15, 125, 240, 1),
        error: Colors.red);
  }

  AppBarTheme _appBarTheme() {
    return AppBarTheme(
        // backgroundColor: colorSchemeLight.colorGreen,
        backgroundColor: colorSchemeLight.backgroundColor,
        titleTextStyle: TextStyle(
            color: colorSchemeLight.colorGrey,
            fontSize: TextConstants.highFontSize),
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: colorSchemeLight.colorGrey,
          size: 32,
        )).copyWith();
  }
}
