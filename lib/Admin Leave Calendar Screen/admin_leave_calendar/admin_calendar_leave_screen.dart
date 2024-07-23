import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/admin_leave_calendar/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/model/common.dart';
import '../../common/provider/manager/provider.dart';
import '../../common/services/common_api.dart';
import '../../common/text_widgets.dart';
import '../../common/utils/image_res.dart';
import '../../common/widgets/app_shadow.dart';
import '../../constants/colors.dart';
import '../widgets/attendance_provider.dart';
import '../widgets/attendance_screenprovider.dart';
import '../widgets/calendar_months_navigation_buttons.dart';
import '../widgets/calendar_refresh.dart';
import '../widgets/calendar_widgets.dart';
import '../widgets/year_popup.dart';

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

class TableLeavesExampleWidget extends ConsumerWidget {
  TableLeavesExampleWidget({
    Key? key,
    required this.onPageChanged,
    required this.leaveData, // Define leaveData parameter here
  }) : super(key: key);

  final Function(DateTime) onPageChanged;

  final Map<DateTime, LeaveCountCalendar>? leaveData;

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

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;

  List<dynamic> _getLeavesForDay(DateTime day) {
    final leaveCount = leaveData![day];

    // Ensure that _leaveData contains the key for the specified day
    if (leaveCount != null && leaveCount.count > 0) {
      return [leaveCount.count]; // Return the leave count for the specified day
    } else {
      // debugPrint("No leave data found for $day");
      return []; // Return an empty list if no leave data is found for the day
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
// Left arrow IconButton
              if (shouldShowLeftArrow(focusedDay, selectedYearIndex))
                IconButton(
                  icon: SvgPicture.asset(
                    ImageRes.left_arrow_calendar,
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () {
                    DateTime newFocusedDay = getValidFocusedDay(
                      DateTime(focusedDay.year, focusedDay.month - 1, 1),
                      kFirstDay,
                      kLastDay,
                    );

                    if (newFocusedDay.month == 0) {
                      newFocusedDay = DateTime(focusedDay.year - 1, 12, 1);
                    }
                    ref.read(userFocusedDayProvider.notifier).state =
                        newFocusedDay;
                    ref.read(selectedYearProvider.notifier).state =
                        newFocusedDay
                            .year; // Update the selected year in the dropdown
                    ref
                        .read(userCalendarLogicsNotifierProvider.notifier)
                        .handleCalendarPageChangeForManagerParticularEmployee(
                          date: ref.read(userFocusedDayProvider.notifier).state,
                          ref: ref,
                        );
                  },
                ),

              const SizedBox(width: 5),

              text15Normal(
                text: DateFormat.MMMM().format(focusedDay),
                color: const Color(0xff585757),
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(width: 5),

// Year dropdown
              YearDropdownButton(
                selectedYear: selectedYear,
                years: years,
                onYearSelected: (newYear) {
                  final newFocusedDay = getValidFocusedDay(
                    DateTime(newYear, focusedDay.month, focusedDay.day),
                    kFirstDay,
                    kLastDay,
                  );

                  ref.read(selectedYearProvider.notifier).state = newYear;
// Update the focused day and selected day with the new year
                  ref.read(userFocusedDayProvider.notifier).state =
                      newFocusedDay;

                  ref.read(userSelectedDayProvider.notifier).state = DateTime(
                    newYear,
                    selectedDay.month,
                    selectedDay.day,
                  );
                },
              ),
// Right arrow IconButton
              IconButton(
                icon: SvgPicture.asset(
                  ImageRes.right_arrow_calendar,
                  height: 20,
                  width: 20,
                ),
                onPressed: () {
                  DateTime newFocusedDay = getValidFocusedDay(
                    DateTime(focusedDay.year, focusedDay.month + 1, 1),
                    kFirstDay,
                    kLastDay,
                  );

                  ref.read(userFocusedDayProvider.notifier).state =
                      newFocusedDay;
                  ref.read(selectedYearProvider.notifier).state = newFocusedDay
                      .year; // Update the selected year in the dropdown
                  ref
                      .read(userCalendarLogicsNotifierProvider.notifier)
                      .handleCalendarPageChange(
                        date: ref.read(userFocusedDayProvider.notifier).state,
                        ref: ref,
                        // userId: userId,
                      );
                },
              ),
              Refresh_CalendarButton(onTap: () {
                ref.read(userRangeStartProvider.notifier).state = null;
                ref.read(userRangeEndProvider.notifier).state = null;
                ref.read(userViewProvider.notifier).state = 'month';
                ref.read(customToggleIndexProvider.notifier).state = 1;
                ref.read(userSelectedDayProvider.notifier).state =
                    DateTime.now();
                ref.read(userFocusedDayProvider.notifier).state =
                    DateTime.now();
                ref.read(calendarFormatProvider.notifier).state =
                    CalendarFormat.month;
                ref.invalidate(userFocusedDayProvider);
              }),
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          TableCalendar<LeaveCountCalendar>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: focusedDay,
            rowHeight: 50,
            daysOfWeekHeight: 40,
            onPageChanged: onPageChanged,
            currentDay: DateTime.now(),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            headerVisible: false,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(fontWeight: FontWeight.w500),
              outsideDaysVisible: true,
              isTodayHighlighted: false,
            ),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, leaves) {
                final rangeStart = ref.watch(userRangeStartProvider);
                final rangeEnd = ref.watch(userRangeEndProvider);
                if (isSameDay(date, rangeStart)) {
// Style for the start of the range
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200, // Start range date color
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (isSameDay(date, rangeEnd)) {
// Style for the end of the range
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200, // End range date color
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (rangeStart != null &&
                    rangeEnd != null &&
                    date.isAfter(rangeStart) &&
                    date.isBefore(rangeEnd)) {
// Style for dates within the selected range
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
// Your color for dates within the range
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (isSameDay(date, DateTime.now())) {
// Style for the current date (today)
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Current date color
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(
                        color: AppColors.greyDarkColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
// Default style for other dates
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100, // Default date color
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              dowBuilder: (context, day) =>
                  CalendarDecorations.dowBuilder(context, day),
              defaultBuilder: (
                context,
                day,
                focusedDay,
              ) {
                // final leave = _getLeavesForDay(day);
                final leaveCount = _getLeavesForDay(day);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.day.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    if (leaveCount.isNotEmpty)
                      Container(
                        width: 70,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            leaveCount.join(''),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
