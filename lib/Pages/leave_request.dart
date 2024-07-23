import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/common/model/common.dart';


import '../widgets/Leave Request/Leave Request Cards/leave_request_history.dart';
import '../widgets/Leave Request/Leave Request Cards/leave_request_history_card.dart';
import '../widgets/Leave Request/Leave Request Cards/leave_request_pending_card.dart';
import '../widgets/Leave Request/Leave requests Table/leave_request_ pending_table.dart';
import '../widgets/Leave Request/Leave requests Table/leave_request_history_table.dart';
import '../widgets/Leave Request/custom_toggle.dart';
import '../widgets/leave_bar_chart.dart';
import '../widgets/leave_pie_chart.dart';

class LeaveRequestPage extends ConsumerStatefulWidget {
  const LeaveRequestPage({super.key});

  @override
  ConsumerState<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends ConsumerState<LeaveRequestPage> {
  @override
  Widget build(BuildContext context) {
    final selectedIndexForToggle =
        ref.watch(customToggleIndexForLeaveRequestProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 40),
              child: Row(
                children: [
                  Text(
                    'Leave Requests',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, bottom: 10.0, right: 20),
                child: CustomToggleSwitchForLeaveRequest(
                  labels: const ["Pending", 'History'],
                  onToggle: (value) {
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Container(
                    child: selectedIndexForToggle == 0
                        ? PendingTableLeaveRequest()
                        : HistoryTableLeaveRequest(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.755,
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: Container(

                    decoration: dashboardDecoration(),
                    child:
                    selectedIndexForToggle==0? PendingDetailsCard() : HistoryDetailsCard(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
          )
        ],
      ),
    );
  }
}

BoxDecoration dashboardDecoration() {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      boxShadow: const [
        BoxShadow(
          // offset: Offset(0.0, 0.51338),
          blurRadius: 0.2,
          spreadRadius: 0.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        )
      ],
      border: Border.all(color: const Color(0xffD5D6D9), width: 1.227));
}
