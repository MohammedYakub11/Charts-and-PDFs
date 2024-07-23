import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/admin_leave_calendar/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Admin Leave Calendar Screen/admin_leave_calendar/admin_calendar_leave_screen.dart';
import 'Admin Leave Calendar Screen/widgets/admin_leave_profile_details.dart';
import 'Admin Leave Calendar Screen/widgets/attendance_provider.dart';
import 'Admin Leave Calendar Screen/widgets/attendance_screenprovider.dart';
import 'Admin Leave Calendar Screen/widgets/calendar_months_navigation_buttons.dart';
import 'Admin Leave Calendar Screen/widgets/calendar_refresh.dart';
import 'Admin Leave Calendar Screen/widgets/year_popup.dart';
import 'Pages/sample_page.dart';
import 'common/model/common.dart';
import 'common/provider/manager/provider.dart';
import 'common/services/common_api.dart';
import 'common/utils/image_res.dart';
import 'common/widgets/app_shadow.dart';




final selectedYearProvider =
    StateProvider.autoDispose<int>((ref) => DateTime.now().year);
final userViewProvider = StateProvider.autoDispose((ref) => 'month');
final userSelectedDayProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final userFocusedDayProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final calendarFormatProvider =
    StateProvider.autoDispose<CalendarFormat>((ref) => CalendarFormat.month);
final userSelectedYearProvider =
    StateProvider.autoDispose<int>((ref) => DateTime.now().year);
final userRangeStartProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);
final userRangeEndProvider =
    StateProvider.autoDispose<DateTime?>((ref) => null);
final userRangeSelectionModeProvider =
    StateProvider.autoDispose<RangeSelectionMode>(
        (ref) => RangeSelectionMode.toggledOn);
final customToggleIndexProvider = StateProvider.autoDispose<int>((ref) => 1);
final userCalendarLogicsNotifierProvider =
    StateNotifierProvider.autoDispose<CalendarLogicsNotifier, DateTime>(
  (ref) => CalendarLogicsNotifier(),
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Map<DateTime, LeaveCountCalendar> _leaveData;
  final CommonApi _commonApi = CommonApi();

  @override
  void initState() {
    super.initState();
    _leaveData = {};

    final DateTime now = DateTime.now();
    final String startDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    final String endDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0));

    // Use the CommonApi instance to call managerTeamLeaveCalendar
    _commonApi
        .managerTeamLeaveCalendar(startDate: startDate, endDate: endDate)
        .then((data) {
      setState(() {
        // Assuming data is a Map<DateTime, int>. Adjust if necessary.
        _leaveData = _convertToLeaveDataMap(data);
      });
    }).catchError((error) {
      debugPrint('Error fetching leave data: $error');
    });

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      ref.read(managerTeamLeaveCalendarProvider.notifier);
    });
  }

  DateTime getValidFocusedDay(
      DateTime date, DateTime firstDay, DateTime lastDay) {
    if (date.isBefore(firstDay)) {
      return firstDay;
    } else if (date.isAfter(lastDay)) {
      return lastDay;
    } else {
      return date;
    }
  }

  DateTime getLastDayForCalendar(DateTime focusedDay) {
    // Calculate the last day of the month for the focused day
    DateTime lastDayOfMonth =
        DateTime(focusedDay.year, focusedDay.month + 1, 0);
    return lastDayOfMonth;
  }

  void onPageChanged(WidgetRef ref, DateTime focusedDay) {
    DateTime newFocusedDay = getValidFocusedDay(
      focusedDay,
      kFirstDay,
      getLastDayForCalendar(focusedDay),
    );

    ref.read(userFocusedDayProvider.notifier).state = newFocusedDay;
  }

  Map<DateTime, LeaveCountCalendar> _convertToLeaveDataMap(
      List<LeaveCountCalendar> data) {
    Map<DateTime, LeaveCountCalendar> leaveDataMap = {};
    for (var leave in data) {
      String dateTime = '${leave.date} 00:00:00.000Z';
      DateTime date = DateTime.parse(dateTime);
      LeaveCountCalendar leaveWithUtcDate = LeaveCountCalendar(
        date: date.toString(),
        count: leave.count,
      );
      leaveDataMap[date] = leaveWithUtcDate;
    }

    return leaveDataMap;
  }

  @override
  Widget build(BuildContext context) {
    final selectedYear = ref.watch(selectedYearProvider);
    final focusedDay = ref.watch(userFocusedDayProvider);
    final selectedDay = ref.watch(userSelectedDayProvider);
    bool shouldShowLeftArrow(DateTime focusedDay, int selectedYearIndex) {
      return !(focusedDay.month == 1 && selectedYearIndex == 0);
    }

    final List<int> years =
        List.generate(2, (index) => DateTime.now().year - 1 + index);
    int selectedYearIndex = years.indexOf(selectedYear);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  // Row(        mainAxisAlignment: MainAxisAlignment.center,
                  //
                  //   children: [
                  //     const CalendarNavigationButtons(),
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.555,
                    width: MediaQuery.of(context).size.width * 0.290,
                    child: Container(
                      decoration: containerDecoration(sR: 1, bR: 1),
                      child: Expanded(
                        child: TableLeavesExampleWidget(
                          onPageChanged: (focusedDay) =>
                              onPageChanged(ref, focusedDay),
                          leaveData: _leaveData,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.295,
                    height: MediaQuery.of(context).size.width * 0.135,
                    child: Expanded(child: PieChartPage()),
                  ),
                ],
              )),
        ],
      )),
    );
  }
}

final managerFocusedDayProvider = StateProvider.autoDispose<DateTime>((ref) {
  ref.onDispose(() {
    debugPrint('focused cleared');
  });
  return DateTime.now();
});

class CalendarLogicsNotifier extends StateNotifier<DateTime> {
  CalendarLogicsNotifier() : super(DateTime.now());

  Future<void> handleCalendarPageChange({
    required DateTime date,
    required WidgetRef ref,
    // required int userId
  }) async {
    final daysInMonth = ref.watch(userDaysInMonthProvider);
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    state = date;
  }

//end
  final userDaysInMonthProvider = StateProvider.autoDispose<String?>((ref) {
    final focusedDay = ref.watch(userFocusedDayProvider);
    return DateUtils.getDaysInMonth(focusedDay.year, focusedDay.month)
        .toString();
  });

    Future<void> handleCalendarPageChangeForParticularEmployee(
      {required DateTime date,
      required WidgetRef ref,
      required int userId}) async {
    final daysInMonth = ref.watch(adminDaysInMonthProvider.notifier).state;
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    state = date;
    // ref.read(userApiNotifierProvider.notifier).fetchUserActivityData(
    //     ref: ref, fromDate: startDate, endDate: endDate, userId: userId);
  }

  Future<void> handleCalendarPageChangeForManagerParticularEmployee({
    required DateTime date,
    required WidgetRef ref,
    // required int userId
  }) async {
    final daysInMonth = ref.watch(managerDaysInMonthProvider.notifier).state;
    var startDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-01';
    var endDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-$daysInMonth';
    // debugPrint('DAYSINMONTHManager:${daysInMonth}');
    state = date;
    // ref.read(userApiNotifierProvider.notifier).fetchUserActivityData(
    //     ref: ref, fromDate: startDate, endDate: endDate, userId: userId);
  }
}
