import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/widgets/year_popup.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/model/common.dart';
import '../../common/text_widgets.dart';
import '../../common/utils/image_res.dart';
import '../../common/widgets/app_shadow.dart';
import '../../home_screen.dart';
import '../admin_leave_calendar/admin_calendar_leave_screen.dart';
import '../admin_leave_calendar/utils.dart';
import 'calendar_refresh.dart';

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

class CalendarNavigationButtons extends ConsumerWidget {
  const CalendarNavigationButtons({super.key});

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
    return Column(
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
                  ref.read(selectedYearProvider.notifier).state = newFocusedDay
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
                ref.read(userFocusedDayProvider.notifier).state = newFocusedDay;

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

                ref.read(userFocusedDayProvider.notifier).state = newFocusedDay;
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
              ref.read(selectedYearProvider.notifier).state= DateTime.now().year;

              ref.read(userRangeStartProvider.notifier).state = null;
              ref.read(userRangeEndProvider.notifier).state = null;
              ref.read(userViewProvider.notifier).state = 'month';
              ref.read(customToggleIndexProvider.notifier).state = 1;
              ref.read(userSelectedDayProvider.notifier).state = DateTime.now();
              ref.read(userFocusedDayProvider.notifier).state = DateTime.now();
              ref.read(calendarFormatProvider.notifier).state =
                  CalendarFormat.month;
              ref.invalidate(userFocusedDayProvider);
            }),
          ],
        ),
      ],
    );
  }
}
