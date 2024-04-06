import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}

void closeAppUsingSystemPop() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

void closeAppUsingExit() {
  exit(0);
}
