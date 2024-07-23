

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminDaysInMonthProvider = StateProvider.autoDispose<String?>((ref) {
  final focusedDay = ref.watch(adminFocusedDayProvider);
  return DateUtils.getDaysInMonth(focusedDay.year, focusedDay.month)
      .toString();
});
final adminFocusedDayProvider = StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
