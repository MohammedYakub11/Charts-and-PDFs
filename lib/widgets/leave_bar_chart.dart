import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testings/User%20Leave%20Card/user_leave_card.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants/text.dart';
import 'leave_custom_toggle.dart';

class LeaveBarChart extends StatefulWidget {
  const LeaveBarChart({super.key});

  @override
  State<LeaveBarChart> createState() => _LeaveBarChartState();
}

class _LeaveBarChartState extends State<LeaveBarChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
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
              const ApplyButton(),
            ],
          ),
        ),
        const Row(
          children: [
            Text(
              "Total Leave Balances",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        const TotalLeaveBalances(),
        const SizedBox(
          height: 15,
        ),
        BarChart(),
      ],
    );
  }
}

class TotalLeaveBalances extends StatelessWidget {
  const TotalLeaveBalances({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.casualLeaveTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "Casual Leave:",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "1.5",
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.sickLeaveTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "Sick Leave:",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "1.5",
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.earnedLeaveTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "Earned Leave:",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "1.5",
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.paternityLeaveTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "Paternity Leave:",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "1.5",
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.wfhTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "Work From Home:",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "1.5",
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lopTheme,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const greyText(
          text: "LOP (Loss of Pay):",
        ),
        const SizedBox(
          width: 8,
        ),
        const subTitleText(
          text: "-1",
        ),
      ],
    );
  }
}

class BarChart extends StatefulWidget {
  BarChart({super.key});

  late Rect? labelRect; // Initialize labelRect here

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  final List<ChartData> chartData = [
    ChartData('Jan', 0, 2, 3, 0, 0, 2),
    ChartData('Feb', 1, 1, 0, 0, 2, 0),
    ChartData('Mar', 0, 0, 2, 0, 0, 0),
    ChartData('Apr', 1, 0, 1, 0, 2, 2),
    ChartData('May', 1, 0, 0, 0, 0, 0),
    ChartData('Jun', 0, 1, 0, 3, 0, 0),
    ChartData('Jul', 0, 0, 0, 0, 0, 3),
    ChartData('Aug', 0, 0, 0, 0, 0, 0),
    ChartData('Sep', 0, 2, 0, 0, 0, 0),
    ChartData('Oct', 2, 0, 0, 0, 0, 0),
    ChartData('Nov', 0, 0, 0, 0, 0, 0),
    ChartData('Dec', 1, 0, 0, 0, 0, 0),
  ];

  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      borderColor: Colors.white,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: series.color, // Column color
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${point.y}',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffD5D6D9),
                width: 1,
              ),
            ),
            width: MediaQuery.of(context).size.height * 1.550,
            height: MediaQuery.of(context).size.height * 0.498,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Total Leaves Taken",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SafeArea(
                    child: Container(
                      height: 300,
                      child: SfCartesianChart(
                        tooltipBehavior: _tooltipBehavior,
                        // Added this line
                        enableAxisAnimation: true,
                        zoomPanBehavior: _zoomPanBehavior,
                        primaryXAxis: CategoryAxis(
                            interval: 1,
                            autoScrollingDelta: 9,

                            // visibleMaximum: 11,
                            autoScrollingMode: AutoScrollingMode.start,
                            isVisible: true,
                            majorGridLines: const MajorGridLines(width: 0.15),
                            majorTickLines: const MajorTickLines(width: 0.0),
                            labelStyle: const TextStyle(
                              color: Color(0xff77838F),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            edgeLabelPlacement: EdgeLabelPlacement.shift),
                        primaryYAxis: NumericAxis(
                            interval: 1,
                            majorTickLines: const MajorTickLines(width: 0.0),
                            majorGridLines: const MajorGridLines(width: 1),
                            // visibleMaximum: 4,
                            plotOffset: 1),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,
                            isVisibleInLegend: true,
                            color: AppColors.casualLeaveTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings: EmptyPointSettings(
                              mode: EmptyPointMode.zero,
                            ),

                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) => ch.casualLeave,
                          ),
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,

                            color: AppColors.sickLeaveTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings:
                                EmptyPointSettings(mode: EmptyPointMode.drop),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) => ch.sickLeave,
                          ),
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,

                            color: AppColors.earnedLeaveTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings:
                                EmptyPointSettings(mode: EmptyPointMode.drop),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) => ch.earnedLeave,
                          ),
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,

                            color: AppColors.paternityLeaveTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings:
                                EmptyPointSettings(mode: EmptyPointMode.drop),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) =>
                                ch.paternityLeave,
                          ),
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,

                            color: AppColors.wfhTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings:
                                EmptyPointSettings(mode: EmptyPointMode.drop),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) => ch.wfh,
                          ),
                          ColumnSeries<ChartData, String>(
                            enableTooltip: true,

                            color: AppColors.lopTheme,
                            width: 0.8,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              topLeft: Radius.circular(1.5),
                            ),
                            emptyPointSettings:
                                EmptyPointSettings(mode: EmptyPointMode.drop),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            dataSource: chartData,
                            xValueMapper: (ChartData ch, _) => ch.month,
                            yValueMapper: (ChartData ch, _) => ch.lop,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final String? month;
  final double? casualLeave;
  final double? sickLeave;
  final double? earnedLeave;
  final double? paternityLeave;
  final double? wfh;
  final double? lop;

  ChartData(
    this.month,
    this.casualLeave,
    this.sickLeave,
    this.earnedLeave,
    this.paternityLeave,
    this.wfh,
    this.lop,
  );
}
