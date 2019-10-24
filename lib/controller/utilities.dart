import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Converts from a hexadecimal string to a color
Color hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
}

String dateTimeFormat(DateTime dateTime, String format) {
  var formatter = DateFormat(format);
  return formatter.format(dateTime);
}