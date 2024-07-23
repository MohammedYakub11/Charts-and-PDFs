import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../Pages/leave_request.dart';
import '../../common/model/common.dart';
import '../../common/model/user.dart';
import '../../common/provider/leave_request/leave_request.dart';
import '../../common/provider/manager/provider.dart';
import '../AdminLeaveCalendar.dart';
import 'admin_calendar_text_widget.dart';

class AdminLeaveEmployeeHistory extends ConsumerStatefulWidget {
  // final Function(Map<String, dynamic> row) onTileSelected;
  // final List<UserLeaveApplyDetails> data;

  const AdminLeaveEmployeeHistory({
    super.key,
    // required this.onTileSelected,
  });

  @override
  _AdminLeaveEmployeeHistoryState createState() =>
      _AdminLeaveEmployeeHistoryState();
}

class _AdminLeaveEmployeeHistoryState
    extends ConsumerState<AdminLeaveEmployeeHistory> {
  final selectedUserIdProvider = StateProvider<int?>((ref) => null);
  final changeEntriesProvider =
      StateProvider.autoDispose<String>((ref) => 'See Previous Entries');

  final ScrollController _scrollController = ScrollController();
  int year = DateTime.now().year;

  void _fetchLeaveData(int year) {
    ref
        .read(yearlyLeaveDetailsHistoryProvider.notifier)
        .getYearlyLeaveDetailsHistory(
          year: year,
        );
  }

  @override
  void initState() {
    super.initState();
    _fetchLeaveData(year); // Fetch data when the widget initializes
  }

  // late List<UserLeaveApplyDetails> data;

  @override
  Widget build(
    BuildContext context,
  ) {
    final yearlyLeaveDetails = ref.read(yearlyLeaveDetailsHistoryProvider);
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            radius: const Radius.circular(5),
            child: ListView.builder(
              itemCount: yearlyLeaveDetails.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                final leaveDetail = yearlyLeaveDetails[index];
                // Format start date
                String formattedStartDate = DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(leaveDetail.startDate));
                // Format end date
                String formattedEndDate = DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(leaveDetail.endDate));

                return Material(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {

                        // for checking
                        /// update the code
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => LeaveRequestPage()));
                      },
                      child: ListTile(
                        onTap: (){
                          ref.read(selectedLeaveDetailProvider.notifier).selectLeaveDetail(leaveDetail);
                        },
                        title: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFC6CDD7), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, top: 15.0, bottom: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AdminLeaveCalendarTextWidget(
                                  title: "No of days : ",
                                  value: leaveDetail.noOfDays.toString(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AdminLeaveCalendarTextWidget(
                                  title: "Duration : ",
                                  value:
                                      '$formattedStartDate - $formattedEndDate',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AdminLeaveCalendarTextWidget(
                                  title: "Leave Type: ",
                                  value: leaveDetail.leaveType,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
// void historyTap(UserLeaveApplyDetails leaveRequest) {
//   widget.onTileSelected(leaveRequest.toMap());
//
//   ref.invalidate(
//       changeEntriesProvider); //while clicking table everytime we ll invalidate this pprovider to show current entries by Default
//   ref
//       .read(LeaveRequestDetailsHistoryProvider.notifier)
//       .getYearlyLeaveDetailsHistory(
//     requestId: leaveRequest.id,
//
//   );
// }
}
