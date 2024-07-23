import 'package:flutter/material.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/leave_apply_dialog_box.dart';

class UserLeaveCard extends StatelessWidget {
   const UserLeaveCard({
    super.key,
    required this.chartData,
    required this.data,
  });

  final List<ChartData1> chartData;
  final CardTitle data;



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 400,
          height: 220,
          child: Row(
            children: [
              Expanded(

                child: SfCircularChart(

                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                      widget: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 42,
                          child: Text(
                            '2.5/5',
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData1, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData1 ch, _) => ch.x,
                      yValueMapper: (ChartData1 ch, _) => ch.y,
                      pointColorMapper: (ChartData1 data, _) => data.color,
                      dataLabelMapper: (ChartData1 data, _) => data.text!,
                      radius: '85%',
                      innerRadius: '80%',
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(width: 10), // Space between columns

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          color: data.color,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff36689E).withOpacity(0.4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xffF3AF00),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "2.5",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xffEF8763),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "1.5",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff4277FA),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff969696),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Requested",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff969696),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Used",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff969696),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Balance",
                                style: TextStyle(
                                  fontFamily: "IBM Plex Sans",
                                  color: Color(0xff969696),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, bottom: 15),
                    child: SizedBox(
                      width: 80, // Set the width
                      height: 32, // Set the height
                      child: ApplyButton(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ChartData1 {
  ChartData1(this.x,
      this.y,
      this.color,
      this.text,);

  final String x;
  final double y;
  final Color color;
  final String? text;
}

class CardTitle {
  CardTitle(this.title,
      this.color,);

  final String title;
  final Color color;
}


class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(context: context,
            builder: (
                context) => const LeaveApplyDialogbox());
      },
      child: Text("Apply", style: TextStyle(
        fontSize: 16, // Example property
      ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          (AppColors.mainTheme),
        ),
      ),
    );
  }
}

