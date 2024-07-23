import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/model/common.dart';

/// Example event class.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final leaveData = await fetchLeaveData();

  final kLeaves = LinkedHashMap<DateTime, LeaveCountCalendar>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(leaveData);

  // Now you can use kLeaves in your calendar
  //...
}

Future<Map<DateTime, LeaveCountCalendar>> fetchLeaveData() async {
  // Load JSON file
  String jsonData = await rootBundle.loadString('assets/sample.json');
  // debugPrint('GEct00:$jsonData');
  // Parse JSON
  List<dynamic> leaveList = jsonDecode(jsonData);
  // debugPrint('lsit:$leaveList');

  // Create a map to store leave data
  Map<DateTime, LeaveCountCalendar> leaveData = {};

  // Extract leave data from JSON and populate the map
  for (var leave in leaveList) {
    // debugPrint('Loop');
    DateTime date = DateTime.parse(leave['date']);
    LeaveCountCalendar leaveCount = LeaveCountCalendar.fromJson(leave);
    leaveData[date] = leaveCount;
    // debugPrint('Count : $count');
    // debugPrint('date : $date');
  }

  return leaveData;
}

///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

//
// final _kLeaveSource = <DateTime, int>{
//   DateTime.utc(kToday.year, 6, 2): 5,
//   DateTime.utc(kToday.year, 6, 7): 2,
//   DateTime.utc(kToday.year, 6, 15): 6,
//   DateTime.utc(kToday.year, 6, 16): 6,
//   DateTime.utc(kToday.year, 6, 17): 6,
//   DateTime.utc(kToday.year, 6, 18): 6,
//   DateTime.utc(kToday.year, 5, 20): 10,
// };

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime.utc(2023, 1, 01);
final kLastDay = DateTime(kToday.year, 12, 31);
