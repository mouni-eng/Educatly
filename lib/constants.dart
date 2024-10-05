import 'package:educatly/models/user_model.dart';
import 'package:educatly/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF007BFB),
  dividerColor: const Color(0xFFC4C4C4).withOpacity(0.8),
  hintColor: const Color(0xFF87878A),
  primaryColorLight: const Color(0xFFFFFFFF),
  primaryColorDark: const Color(0xFF000000),
  textTheme: GoogleFonts.poppinsTextTheme(),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFFF9F9FB),
  splashColor: const Color(0xFFFFFFFF),
  canvasColor: const Color(0xFFF6F6F6),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),
    primary: const Color(0xFF00ACEE),
    secondary: const Color(0xFFE1FFD4),
    secondaryContainer: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFFF9F9FB),
    tertiary: const Color(0xFFeae7df),
    tertiaryContainer: const Color(0xFFEFEFEF),
  ),
);

ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF007BFB),
    primaryColorLight: const Color(0xFF171717),
    primaryColorDark: const Color(0xFFCBE4DE),
    hintColor: const Color.fromRGBO(253, 253, 253, 0.55),
    textTheme: GoogleFonts.poppinsTextTheme(),
    splashColor: const Color(0xFF2C2C2D),
    cardColor: const Color(0xFF2C2C2D),
    scaffoldBackgroundColor: const Color(0xFF000000),
    dividerColor: const Color(0xFF333333),
    canvasColor: const Color(0xFF171717),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFFFFF),
      primary: const Color(0xFF00ACEE),
      secondary: const Color(0xFF005146),
      secondaryContainer: const Color(0xFF005146),
      primaryContainer: const Color(0xFFF9F9FB),
      tertiary: const Color(0xFF000000),
      tertiaryContainer: const Color(0xFF333333),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    ));

EdgeInsets padding = EdgeInsets.symmetric(
  horizontal: width(20),
  vertical: height(20),
);

BoxShadow boxShadow = BoxShadow(
  color: const Color(0xFF000000).withOpacity(0.1), //color of shadow
  //spread radius
  blurRadius: width(30), // blur radius
  offset: const Offset(0, 8),
);

const userRef = "users";
const chatRef = "chats";
const messageRef = "messages";
const themeRef = "themeData";

UserModel? userModel;

ThemeData theme = lightTheme;
