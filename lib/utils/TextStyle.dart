import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import 'autoSizeText.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Typography helpers
// ─────────────────────────────────────────────────────────────────────────────
// By default these helpers use the system font.
// To use Poppins (or any custom font):
//   1. Add the font files to assets/fonts/
//   2. Register them in pubspec.yaml under the `fonts:` section
//   3. Replace the fontFamily strings below (e.g. 'Poppins')
// ─────────────────────────────────────────────────────────────────────────────

/// Regular weight text style. Set [fontFamily] in pubspec to use a custom font.
TextStyle poppinsRegular({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? latterSpacing,
  TextOverflow? textOverflow,
}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    color: color ?? Colors.grey,
    fontWeight: fontWeight ?? FontWeight.w400,
    // fontFamily: 'Poppins', // uncomment after registering the font in pubspec.yaml
    letterSpacing: latterSpacing ?? 0,
    overflow: textOverflow,
  );
}

/// Bold weight text style.
TextStyle poppinsBold({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? latterSpacing,
  FontStyle? fontStyle,
  TextOverflow? textOverflow,
}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    fontStyle: fontStyle ?? FontStyle.normal,
    color: color ?? Colors.grey,
    fontWeight: fontWeight ?? FontWeight.w700,
    // fontFamily: 'Poppins', // uncomment after registering the font
    letterSpacing: latterSpacing ?? 0,
    overflow: textOverflow,
  );
}

/// Semi-bold weight text style.
TextStyle poppinsSemiBold({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? latterSpacing,
  FontStyle? fontStyle,
  TextOverflow? textOverflow,
}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    fontStyle: fontStyle ?? FontStyle.normal,
    color: color ?? Colors.grey,
    fontWeight: fontWeight ?? FontWeight.w600,
    // fontFamily: 'Poppins',
    letterSpacing: latterSpacing ?? 0,
    overflow: textOverflow,
  );
}

/// Light weight text style.
TextStyle poppinsLight({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  double? latterSpacing,
  TextOverflow? textOverflow,
}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    color: color ?? Colors.grey,
    fontWeight: fontWeight ?? FontWeight.w300,
    // fontFamily: 'Poppins',
    letterSpacing: latterSpacing ?? 0,
    overflow: textOverflow,
  );
}

/// Auto-sizing text widget.
Widget autoSizeTextWidget({
  String? text,
  double? fontSize,
  double? maxFontSize,
  TextStyle? otherStyling,
}) {
  return AutoSizeText(
    text!,
    minFontSize: fontSize ?? 12,
    maxFontSize: maxFontSize ?? 25,
    style: otherStyling ?? poppinsRegular(),
  );
}

/// Formats seconds into mm:ss or hh:mm:ss.
String formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  final hoursStr = hours.toString().padLeft(2, '0');
  final minutesStr = minutes.toString().padLeft(2, '0');
  final secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return hours == 0 ? '$minutesStr:$secondsStr' : '$hoursStr:$minutesStr:$secondsStr';
}

/// Returns the full name from an object with firstName and lastName fields.
String getNames(dynamic data) {
  return '${data.firstName} ${data.lastName}'.capitalizeFirst!;
}
