
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/utils/date_utils.dart';
import 'attendance_screenprovider.dart';

// Create a StateNotifier for managing API-related state


final staticDataProvider = Provider<Map<DateTime, String?>>((ref) {
  // You can use this provider to access the static data
  return {}; // Return initial data or fetch it from the notifier state if needed
});
// final userApiNotifierProvider =
// StateNotifierProvider<UserApiNotifier, List<EmployeeActivity>?>((ref) {
//   return UserApiNotifier();
// });

final selectedYearProvider = StateProvider.autoDispose<int>((ref) => DateTime.now().year);
final userViewProvider = StateProvider.autoDispose((ref) => 'month');
final userSelectedDayProvider = StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final userFocusedDayProvider = StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final calendarFormatProvider = StateProvider.autoDispose<CalendarFormat>((ref)=>CalendarFormat.month);
final userSelectedYearProvider = StateProvider.autoDispose<int>((ref) => DateTime.now().year);
final userRangeStartProvider = StateProvider.autoDispose<DateTime?>((ref)=>null);
final userRangeEndProvider = StateProvider.autoDispose<DateTime?>((ref)=>null);
final userRangeSelectionModeProvider = StateProvider.autoDispose<RangeSelectionMode>((ref)=>RangeSelectionMode.toggledOn);
final userCalendarLogicsNotifierProvider = StateNotifierProvider.autoDispose<CalendarLogicsNotifier, DateTime>((ref) => CalendarLogicsNotifier(),);
class CalendarLogicsNotifier extends StateNotifier<DateTime> {
  CalendarLogicsNotifier() : super(DateTime.now());

  Future<void> handleCalendarPageChange({required DateTime date,required WidgetRef ref,}) async {

    final daysInMonth = ref.watch(userDaysInMonthProvider);
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    state = date;
    // ref.read(userApiNotifierProvider.notifier).fetchUserActivityData(ref: ref,fromDate: startDate, endDate: endDate,userId: userId);

  }
  Future<void> handleCalendarPageChangeForParticularEmployee({required DateTime date,required WidgetRef ref,required int userId}) async {

    final daysInMonth = ref.watch(adminDaysInMonthProvider.notifier).state;
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    state = date;
    // ref.read(userApiNotifierProvider.notifier).fetchUserActivityData(ref: ref,fromDate: startDate, endDate: endDate,userId: userId);

  }
  Future<void> handleCalendarPageChangeForManagerParticularEmployee({required DateTime date,required WidgetRef ref,}) async {

    final daysInMonth = ref.watch(managerDaysInMonthProvider.notifier).state;
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    debugPrint('DAYSINMONTHManager:${daysInMonth}');
    state = date;
    // ref.read(userApiNotifierProvider.notifier).fetchUserActivityData(ref: ref,fromDate: startDate, endDate: endDate,userId: userId);

  }
}
final userCurrentWeekProvider = StateProvider<Map<String, DateTime>>((ref) {
  final dateUtils = DateUtilsOfWeek();
  return dateUtils.getCurrentWeek();
});
final userDaysInMonthProvider = StateProvider.autoDispose<String?>((ref) {
  final focusedDay = ref.watch(userFocusedDayProvider);
  return DateUtils.getDaysInMonth(focusedDay.year, focusedDay.month).toString();
});

final filterQueryProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

///user api class

class EmployeeActivity {
  final DateTime date;
  final int userId;
  final String workMode;
  final String? loginTime;
  final String? logoutTime;
  final String? totalWorkingHours;
  final String? totalBreakHours;
  final String? lateBy;
  final String? status;
  final String? shiftName;
  final int id;
  final String shiftStartTime;
  final bool isRegularized;
  final bool hasPendingOrTransferRegularization;

  EmployeeActivity(
      {required this.date,
        required this.userId,
        required this.workMode,
        required this.loginTime,
        required this.logoutTime,
        required this.totalWorkingHours,
        required this.totalBreakHours,
        required this.lateBy,
        required this.status,
        required this.shiftName,
        required this.id,
        required this.shiftStartTime,
        required this.isRegularized,
        required this.hasPendingOrTransferRegularization
      });

  factory EmployeeActivity.fromJson(Map<String, dynamic> json) {
    return EmployeeActivity(
      userId: json['userId']??0,
      date: DateFormat('yyyy-MM-dd').parse(json['date']),
      workMode: json['workMode'] ?? '----',
      loginTime: json['loginTime'] ??'--:--:--',
      logoutTime: json['logoutTime']??'--:--:--',
      lateBy: json['lateBy'],
      totalWorkingHours: json['totalWorkingHours']??'--:--:--',
      totalBreakHours: json['totalBreaksHours']??'--:--:--',
      status: json['status']??'',
      shiftName: json['shiftName']??'----',
      id:json['id']??0,
      shiftStartTime: json['shiftStartTime']??'',
      isRegularized: json['isRegularized']??false,
      hasPendingOrTransferRegularization: json['hasPendingOrTransferRegularization']??false,
    );
  }
}

final managerDaysInMonthProvider = StateProvider.autoDispose<String?>((ref) {
  final focusedDay = ref.watch(managerFocusedDayProvider);
  return DateUtils.getDaysInMonth(focusedDay.year, focusedDay.month)
      .toString();
});
final managerFocusedDayProvider = StateProvider.autoDispose<DateTime>((ref) {
  ref.onDispose(() {
    debugPrint('focused cleared');
  });
  return DateTime.now();
});

