import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Colors
const COLOR_WHITE = Color(0xffFFFFFF);
const COLOR_PURPLE_CARD_BUTTON = Color(0xffC7A7F0);
const COLOR_PURPLE_TEXT = Color(0xff9469C9);
const COLOR_PURPLE_CARD = Color(0xffD4C1EC);
const COLOR_RED_CARD_BUTTON = Color(0xffFF898F);
const COLOR_RED_TEXT = Color(0xffA95156);
const COLOR_RED_CARD = Color(0xffFFACB0);
const COLOR_GREEN_CARD_BUTTON = Color(0xffB1EDC0);
const COLOR_GREEN_TEXT = Color(0xff2DA34B);
const COLOR_GREEN_CARD = Color(0xffD6F6DD);
const COLOR_GREY = Color(0xff4E4E4E);
const COLOR_WHITE_GREY = Color(0xffF4F4F4);

//Font
const String FONT_NUNITO = "Nunito";

// Utils
String formatHours(DateTime time) {
  DateFormat hourFormat = DateFormat('H:mm');
  return hourFormat.format(time);
}

String formatDate(DateTime time) {
  DateFormat hourFormat = DateFormat('EEEE d MMMM', 'fr_FR');
  return hourFormat.format(time).capitalize();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}