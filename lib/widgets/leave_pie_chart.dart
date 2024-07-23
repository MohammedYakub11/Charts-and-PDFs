import 'package:flutter/material.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../User Leave Card/user_leave_card.dart';
import 'leave_custom_toggle.dart';

class LeavePieChart extends StatefulWidget {
  const LeavePieChart({super.key});

  @override
  State<LeavePieChart> createState() => _LeavePieChartState();
}

class _LeavePieChartState extends State<LeavePieChart> {

  final List<ChartData1> chartData1 = [
    ChartData1('', 2.5, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 2.5, const Color(0xff4277FA), ''),
  ];
  final List<ChartData1> chartData2 = [
    ChartData1('', 2, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 2, const Color(0xff4277FA), ''),
  ];
  final List<ChartData1> chartData3 = [
    ChartData1('', 1, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 1, const Color(0xff4277FA), ''),
  ];
  final List<ChartData1> chartData4 = [
    ChartData1('', 1, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 1, const Color(0xff4277FA), ''),
  ];
  final List<ChartData1> chartData5 = [
    ChartData1('', 1, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 1, const Color(0xff4277FA), ''),
  ];
  final List<ChartData1> chartData6 = [
    ChartData1('', 1, const Color(0xffEF8763), ''),
    ChartData1('', 1, const Color(0xffF3AF00), ''),
    ChartData1('', 1, const Color(0xff4277FA), ''),
  ];
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,bottom: 10.0),
              child: CustomToggleSwitchForLeaveApply(
                icons: const [
                  Icons.donut_small_sharp,
                  Icons.bar_chart_rounded
                ],
                onToggle: (value) {
                  debugPrint('Selected index: $value');
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            UserLeaveCard(
              chartData: chartData1,
              data: CardTitle(
                "Casual Leave",
                AppColors.casualLeaveTheme,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            UserLeaveCard(
              chartData: chartData2,
              data: CardTitle(
                "Sick Leave",
                AppColors.sickLeaveTheme,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            UserLeaveCard(

              chartData: chartData3,
              data: CardTitle(
                "Earned Leave",
                AppColors.earnedLeaveTheme,
              ),
            ),
          ],
        ),
        Row(
          children: [
            UserLeaveCard(
              chartData: chartData4,
              data: CardTitle(
                "Paternity Leave",
                AppColors.paternityLeaveTheme,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            UserLeaveCard(
              chartData: chartData5,
              data: CardTitle(
                "Work From Home",
                AppColors.wfhTheme,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            UserLeaveCard(
              chartData: chartData6,
              data: CardTitle(
                "LOP (Loss of Pay)",
                AppColors.lopTheme,
              ),
            ),
          ],
        ),

      ],
    );
  }
}
