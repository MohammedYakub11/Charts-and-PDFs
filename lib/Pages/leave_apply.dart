import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/leave_bar_chart.dart';
import '../widgets/leave_custom_toggle.dart';
import '../widgets/leave_pie_chart.dart';

class LeaveApply extends ConsumerStatefulWidget {
  const LeaveApply({
    super.key,
  });

  @override
  ConsumerState<LeaveApply> createState() => _LeaveApplyState();
}

class _LeaveApplyState extends ConsumerState<LeaveApply> {
  @override
  Widget build(BuildContext context) {
    final selectedIndexForToggle =
        ref.watch(customToggleIndexForLeaveApplyProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 40),
                      child: Row(
                        children: [
                          Text(
                            'Leave Apply',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 40),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.715,
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: selectedIndexForToggle == 0
                          ? const LeavePieChart()
                          : const LeaveBarChart(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
