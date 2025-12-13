import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

String timeAddedFormatted(String timeAdded) {
  String result = '';
  result = formatDate(DateTime.parse(timeAdded), [
    HH,
    ':',
    nn,
    "\n",
    dd,
    "/",
    ' ',
    mm,
    "/",
    " ",
    yyyy,
  ], locale: const ArabicDateLocale());
  return result;
}

String timeAddedSubsFormatted(String timeAdded) {
  String result = '';
  result = formatDate(DateTime.parse(timeAdded), [
    dd,
    ' ',
    M,
    ' ',
    yyyy,
  ], locale: const ArabicDateLocale());
  return result;
}

String timeAddedGroupingFormatted(String timeAdded) {
  String result = '';
  if (DateUtils.isSameDay(DateTime.now(), DateTime.parse(timeAdded))) {
    result = "اليوم";
  } else if (DateUtils.isSameDay(
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.parse(timeAdded),
  )) {
    result = "الأمس";
  } else {
    result = formatDate(DateTime.parse(timeAdded), [
      dd,
      ' ',
      M,
      ' ',
      yyyy,
    ], locale: const ArabicDateLocale());
  }
  return result;
}
