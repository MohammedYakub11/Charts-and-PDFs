import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../common/model/common.dart';
import '../common/provider/manager/provider.dart';
import '../common/services/common_api.dart';
import '../common/text_widgets.dart';
import '../constants/colors.dart';
import '../widgets/leave_apply_dialog_box.dart';
import '../widgets/leave_card_text_widget.dart';

class PieChartPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends ConsumerState<PieChartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), // Duration of the rotation
      vsync: this,
    );
    // ..repeat()
    _controller.forward();
    debugPrint('Initializing PieChartPage');

    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _fetchLeaveData();
    });
    // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchLeaveData() {
    final DateTime now = DateTime.now();
    final String startDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    final String endDate =
        DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0));
    debugPrint('Fetching leave data from $startDate to $endDate');

    ref
        .read(managerTeamLeavePieChartProvider.notifier)
        .getManagerTeamLeavePieChart(
          startDate: startDate,
          endDate: endDate,
        );
  }

  @override
  Widget build(BuildContext context) {
    final leavePieChartValue = ref.watch(managerTeamLeavePieChartProvider);
    debugPrint('Building PieChartPage with data: ${leavePieChartValue.length}');
    final totalValue = leavePieChartValue
        .firstWhere((data) => data.type == 'total',
            orElse: () => LeaveData(type: 'total', value: 0))
        .value;
    return Scaffold(
      body: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: Text(
                    "Types of Leave Taken",
                    // data.title,
                    style: TextStyle(
                      fontFamily: "IBM Plex Sans",
                      color: Colors.black87,
                      // data.color,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(_controller),
                            child: PieChart(
                              PieChartData(
                                sections: _buildPieChartSections(),
                                centerSpaceRadius: 40,
                                sectionsSpace: 0,
                              ),
                              swapAnimationDuration:
                                  Duration(milliseconds: 150),
                              swapAnimationCurve: Curves.linear,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$totalValue",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ScrollConfiguration(
                      behavior: NoScrollbarBehavior(),
                      child: GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / (440),
                        // Adjust this ratio to your needs
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 2,
                        children: leaveTypeItems(leavePieChartValue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> leaveTypeItems(List<LeaveData> leaveDataList) {
    final List<Widget> items = [];
    for (final leaveData in leaveDataList) {
      if (leaveData.type == 'total') continue; // Skip the 'total' item

      final String type = leaveData.type;
      final double value = leaveData.value;
      items.add(
        leaveType(
          getColorForLeaveType(type),
          // Assuming getColorForLeaveType method maps leave types to colors
          type,
          value.toString(),
        ),
      );
    }
    return items;
  }

  Widget leaveType(Color color, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          SizedBox(width: 4),
          Text('$title: $value', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final leaveDataList = ref.watch(managerTeamLeavePieChartProvider);
    return leaveDataList.map((data) {
      return PieChartSectionData(
        color: getColorForLeaveType(data.type),
        value: data.value.toDouble(),
        title: '',
        radius: 12.5,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color getColorForLeaveType(String type) {
    switch (type) {
      case 'Casual Leave':
        return AppColors.casualLeaveTheme;
      case 'Sick Leave':
        return AppColors.sickLeaveTheme;
      case 'Earned Leave':
        return AppColors.earnedLeaveTheme;
      case 'Paternity Leave':
        return AppColors.paternityLeaveTheme;
      case 'Work From Home':
        return AppColors.wfhTheme;
      case 'Loss Of Pay':
        return AppColors.lopTheme;
      default:
        return Colors.grey; // or any default color
    }
  }
}

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
