import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_testings/Admin%20Shift%20Roster%20Table/paginated_table_for_roster.dart';
import 'package:flutter_testings/Admin%20Shift%20Roster%20Table/search_box.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Admin Leave Calendar Screen/widgets/attendance_provider.dart';
import '../Admin Leave Calendar Screen/widgets/calendar_months_navigation_buttons.dart';
import '../Pages/leave_request.dart';
import 'admin_roster_navigation_buttons.dart';

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

class AdminShiftRosterTable extends ConsumerStatefulWidget {
  const AdminShiftRosterTable({super.key});

  @override
  ConsumerState<AdminShiftRosterTable> createState() =>
      _AdminShiftRosterTableState();
}

class _AdminShiftRosterTableState extends ConsumerState<AdminShiftRosterTable> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          decoration: dashboardDecoration(),
          height: MediaQuery.of(context).size.height * 0.68,
          width: MediaQuery.of(context).size.width * 0.712,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // All Employees List
                  Container(
                    width: MediaQuery.of(context).size.width * 0.165,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Color(0x8071839B),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Text(
                              'All Employees',
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.mainTheme),
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0x8071839B),
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.5452,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.5),
                                  child: Row(
                                    children: [
                                      CalendarRefreshButton(),
                                      Text(
                                        'This Week',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.greyDarkColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0.0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  size: 18,
                                                  Icons.edit_outlined,
                                                  color: Colors.redAccent,
                                                ),
                                                splashRadius: 0.1,
                                              ),
                                              // Add some space between the icon and the text
                                              Text(
                                                'Assign Shift',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      AppColors.greyDarkColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.020,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AdminRosterTableNavigationButtons(),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0x8071839B),
                          thickness: 1,
                          height: 1,
                          endIndent: 0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaginatedTableForRoster(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
